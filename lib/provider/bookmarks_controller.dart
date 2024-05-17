import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techno_news/utils/helper_function.dart';

class BookmarkController extends ChangeNotifier {
  List<String> bookmarks = [];
  bool adding = false;
  Future<void> getAllBookMarks() async {
    final data = await FirebaseFirestore.instance
        .collection('bookmarks')
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (var element in data.docs) {
      bookmarks.add(element['news_id']);
    }
  }

  Future<List<dynamic>> getAllBookmarksNews() async {
    List<dynamic> news = [];
    for (var element in bookmarks) {
      final data = await FirebaseFirestore.instance
          .collection('news')
          .doc(element)
          .get();
      if (data.exists) {
        news.add(data);
      }
    }
    return news;
  }

  Future<void> deleteBookmarks(String newsId) async {
    final data = await FirebaseFirestore.instance
        .collection('bookmarks')
        .where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('news_id', isEqualTo: newsId)
        .get();
    for (var element in data.docs) {
      await FirebaseFirestore.instance
          .collection('bookmarks')
          .doc(element.id)
          .delete();
    }
    if (bookmarks.remove(newsId)) {
      notifyListeners();
    }
  }

  Future<void> addToBookMark(String id) async {
    adding = true;
    notifyListeners();
    try {
      await FirebaseFirestore.instance.collection('bookmarks').add({
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'news_id': id,
        'date_added': DateTime.now().microsecondsSinceEpoch,
      });
      bookmarks.add(id);
    } catch (e) {
      handleToastError('Something went wrong while adding to bookmarks');
    }
    adding = false;
    notifyListeners();
  }
}
