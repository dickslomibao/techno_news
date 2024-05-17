import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile'),
            ButtonWidget(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // await FirebaseAuth.instance.signOut();
                // Restart.restartApp();
              },
              title: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
