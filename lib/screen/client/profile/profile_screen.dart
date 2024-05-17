import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
import 'package:techno_news/screen/restart_widget.dart';
import 'package:techno_news/shared_widgets/buttons/button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Profile'),
              const SizedBox(
                height: 15,
              ),
              ButtonWidget(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    RestartWidget.restartApp(context);
                  }
                },
                title: 'Logout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
