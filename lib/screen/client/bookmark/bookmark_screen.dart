import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/provider/bookmarks_controller.dart';
import 'package:techno_news/shared_widgets/cards/news_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    // final read = context.read<NewsCategoryController>();
    context.watch<BookmarkController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2A55),
        title: const Text(
          'Bookmarks',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: context.read<BookmarkController>().getAllBookmarksNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something Went Wrong.'),
              );
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Your book mark is empty.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF9397A0),
                  ),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final news = snapshot.data![index];
                return NewsCard(
                  news: news,
                  dismissible: true,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
