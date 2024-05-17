import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:techno_news/utils/form_validator_function.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:techno_news/utils/helper_function.dart';

class NewsController extends ChangeNotifier {
  Stream<QuerySnapshot<Map<String, dynamic>>> getNewsSnapshots() {
    return FirebaseFirestore.instance
        .collection('news')
        .orderBy('date_created', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNewsByCategorySnapshots(
      String id) {
    return FirebaseFirestore.instance
        .collection('news')
        .where('categories', arrayContains: id)
        .orderBy('date_created', descending: true)
        .snapshots();
  }

  Future<bool> createNews(
      {required List<ImageFile> images,
      required List<String> categories,
      required String title,
      required String content}) async {
    try {
      if (!validateCreateNewsForm(
        images: images,
        categories: categories,
        title: title,
        content: content,
      )) {
        return false;
      }
      List<String> newsImages = [];
      for (final image in images) {
        if (image.hasPath) {
          final photo = File(image.path!);

          final fileName = basename(photo.path);
          final destination =
              'images/${DateTime.now().microsecondsSinceEpoch}$fileName';
          final ref = FirebaseStorage.instance.ref().child(destination);
          await ref.putFile(photo);
          newsImages.add(await ref.getDownloadURL());
        }
      }
      await FirebaseFirestore.instance.collection('news').add({
        'categories': categories,
        'title': title,
        'content': content,
        'date_created': DateTime.now().microsecondsSinceEpoch,
        'images': newsImages,
      });
      return true;
    } catch (e) {
      handleToastError('Something went wrong. Please Try Again.');
      return false;
    }
  }
}
