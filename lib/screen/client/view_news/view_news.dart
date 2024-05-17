import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/provider/bookmarks_controller.dart';
import 'package:techno_news/provider/new_category_controller.dart';

class ViewNewsScreen extends StatefulWidget {
  const ViewNewsScreen({super.key, required this.news, this.admin = false});
  final dynamic news;
  final bool admin;
  @override
  State<ViewNewsScreen> createState() => _ViewNewsScreenState();
}

class _ViewNewsScreenState extends State<ViewNewsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String categories = '';
    final c = context.read<NewsCategoryController>().categories;
    final dateCreated =
        DateTime.fromMicrosecondsSinceEpoch(widget.news['date_created']);
    for (var element in widget.news['categories'] as List<dynamic>) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: height,
        width: width,
        child: Stack(
          children: [
            Container(
              width: width,
              height: height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.news['images'].first),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Color.fromRGBO(9, 37, 71, .2),
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xfff092547),
                          ),
                        ),
                      ),
                      if (!widget.admin)
                        Consumer<BookmarkController>(
                          builder: (context, value, child) => GestureDetector(
                            onTap: value.adding ||
                                    value.bookmarks.contains(widget.news.id)
                                ? null
                                : () {
                                    value.addToBookMark(widget.news.id);
                                  },
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromRGBO(147, 151, 160, .5),
                              child: value.adding
                                  ? LoadingAnimationWidget.beat(
                                      size: 15,
                                      color: Colors.white,
                                    )
                                  : value.bookmarks.contains(widget.news.id)
                                      ? const Icon(
                                          Icons.bookmark_added_rounded,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.bookmark_add_outlined,
                                          color: Colors.white,
                                        ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              margin: EdgeInsets.only(
                top: height / 4,
                bottom: 15,
              ),
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.news['title'],
                      style: const TextStyle(
                        color: Color(0xfff092547),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      categories,
                      style: const TextStyle(
                        color: Color(0xFF9397A0),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: const Color(0xFF716E6E),
                    ),
                    const SizedBox(
                      height: 15,
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
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      widget.news['content'],
                      style: const TextStyle(
                        color: Color(0xFF19202D),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    MasonryGridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.news['images'].length,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor:
                                  const Color.fromRGBO(0, 0, 0, .8),
                              builder: (context) => Container(
                                padding: const EdgeInsets.all(15),
                                height: height,
                                child: Hero(
                                  tag: index,
                                  child: Image.network(
                                    widget.news['images'][index],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 200,
                            child: Hero(
                              tag: index,
                              child: Image.network(
                                widget.news['images'][index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
