import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/provider/new_category_controller.dart';
import 'package:techno_news/provider/news_controller.dart';
import 'package:techno_news/shared_widgets/cards/news_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<NewsCategoryController>();
    context.watch<NewsCategoryController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2A55),
        title: const Text(
          'Explore',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    context.read<NewsCategoryController>().categories.length,
                itemBuilder: (context, index) {
                  final c = read.categories[index];
                  return Container(
                    margin: const EdgeInsets.only(
                      right: 15,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                      color: read.active == c.id
                          ? const Color(0xff0A2A55)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xff0A2A55),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              read.changeActiveValue(c.id);
                            },
                            child: Text(
                              c.title,
                              style: TextStyle(
                                color: read.active == c.id
                                    ? Colors.white
                                    : const Color(0xff0A2A55),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: const Color(0xFF716E6E),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: context
                    .read<NewsController>()
                    .getNewsByCategorySnapshots(read.active),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data == null) {
                    return const Center(child: Text('No result.'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      final news = snapshot.data!.docs[index];
                      return NewsCard(news: news);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
