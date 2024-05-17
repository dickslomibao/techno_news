import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/firebase_options.dart';
import 'package:techno_news/provider/authenticaton/auth.dart';
import 'package:techno_news/provider/bookmarks_controller.dart';
import 'package:techno_news/provider/new_category_controller.dart';
import 'package:techno_news/provider/news_controller.dart';
import 'package:techno_news/screen/admin/create_news/create_news_screen.dart';
import 'package:techno_news/screen/auth/authentication_screen.dart';
import 'package:techno_news/screen/auth/login_screen/login_screen.dart';
import 'package:techno_news/screen/auth/register_screen/register_screen.dart';
import 'package:techno_news/screen/client/home/home_screen.dart';
import 'package:techno_news/screen/client/main_screen.dart';
import 'package:techno_news/screen/screen_resources_loader.dart';
import 'package:techno_news/screen/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsCategoryController(),
        ),
        ChangeNotifierProvider(
          create: (context) => NewsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarkController(),
        )
      ],
      child: MaterialApp(
        builder: FToastBuilder(),
        title: 'Techno News',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Consumer<AuthController>(
          builder: (context, value, child) => value.showSplash
              ? const SplashScreen()
              : value.isLogin
                  ? const ScreenResourcesLoader()
                  : const AuthenticationScreen(),
        ),
      ),
    );
  }
}
