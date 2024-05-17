import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/provider/bookmarks_controller.dart';
import 'package:techno_news/provider/new_category_controller.dart';
import 'package:techno_news/screen/admin/create_news/create_news_screen.dart';
import 'package:techno_news/screen/admin/home/admin_home_screen.dart';
import 'package:techno_news/screen/client/home/home_screen.dart';
import 'package:techno_news/screen/client/main_screen.dart';

class ScreenResourcesLoader extends StatefulWidget {
  const ScreenResourcesLoader({super.key});

  @override
  State<ScreenResourcesLoader> createState() => _ScreenResourcesLoaderState();
}

class _ScreenResourcesLoaderState extends State<ScreenResourcesLoader> {
  Future<void> loadResources() async {
    await Future.wait([
      context.read<NewsCategoryController>().getCategory(),
      context.read<BookmarkController>().getAllBookMarks(),
    ]);
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (context.mounted) {
      print(data.data());
      if (!data.exists ||
          (data.data()!.containsKey('type') && data['type'] != 'admin')) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
        return;
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AdminHomeScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    loadResources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
