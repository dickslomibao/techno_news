import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/provider/bookmarks_controller.dart';
import 'package:techno_news/provider/new_category_controller.dart';
import 'package:techno_news/screen/client/view_news/view_news.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key, required this.news, this.dismissible = false})
      : super(key: key);
  final news;
  final bool dismissible;
  @override
  Widget build(BuildContext context) {
    String categories = '';
    final c = context.read<NewsCategoryController>().categories;
    final dateCreated =
        DateTime.fromMicrosecondsSinceEpoch(news['date_created']);
    for (var element in news['categories'] as List<dynamic>) {
      final result = c.where((e) => e.id == element).toList();
      if (result.isEmpty) {
        continue;
      }
      if (categories.isEmpty) {
        categories += result.first.title;
      } else {
        categories += ', ${result.first.title}';
      }
    }
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: ViewNewsScreen(
            news: news,
          ),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          // color: const Color(0xffEFF9FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Dismissible(
          onDismissed: (d) {
            context.read<BookmarkController>().deleteBookmarks(news.id);
          },
          direction:
              dismissible ? DismissDirection.startToEnd : DismissDirection.none,
          key: UniqueKey(),
          background: Container(
            decoration: BoxDecoration(
              color: const Color(0xffEEBEBE),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 36,
                ),
              ],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  (news['images'] as List<dynamic>).first,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category: $categories',
                            style: const TextStyle(
                              color: Color(0xFF9397A0),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            news['title'] +
                                "asda sda d asd as das dsa da sd asd as d asd asd ad a d as sd",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_month_rounded,
                                size: 18,
                                color: Color(0xFF9397A0),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(dateCreated)
                                    .toString(),
                                style: const TextStyle(
                                  color: Color(0xFF9397A0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.timelapse_outlined,
                                size: 18,
                                color: Color(0xFF9397A0),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                DateFormat('hh:mm a')
                                    .format(dateCreated)
                                    .toString(),
                                style: const TextStyle(
                                  color: Color(0xFF9397A0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
