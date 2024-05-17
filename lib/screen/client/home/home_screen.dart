import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:techno_news/provider/new_category_controller.dart';
import 'package:techno_news/provider/news_controller.dart';
import 'package:techno_news/screen/auth/authentication_screen.dart';
import 'package:techno_news/screen/auth/login_screen/login_screen.dart';
import 'package:techno_news/screen/client/home/widgets/main_header.dart';
import 'package:techno_news/shared_widgets/buttons/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:techno_news/shared_widgets/cards/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<NewsCategoryController>().getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const MainHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Latest News',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
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
                    height: 20,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: context.read<NewsController>().getNewsSnapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.data == null) {
                          return const Center(child: Text('News is empty'));
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
          ),
        ],
      ),
    );
  }
}
