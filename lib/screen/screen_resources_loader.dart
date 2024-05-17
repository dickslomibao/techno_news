import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/provider/new_category_controller.dart';
import 'package:techno_news/screen/admin/create_news/create_news_screen.dart';
import 'package:techno_news/screen/client/home/home_screen.dart';
import 'package:techno_news/screen/client/main_screen.dart';

class ScreenResourcesLoader extends StatefulWidget {
  const ScreenResourcesLoader({super.key});

  @override
  State<ScreenResourcesLoader> createState() => _ScreenResourcesLoaderState();
}

class _ScreenResourcesLoaderState extends State<ScreenResourcesLoader> {
  Future<void> loadResources() async {
    await context.read<NewsCategoryController>().getCategory();
    if (context.mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const CreateNewsScreen(),
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
