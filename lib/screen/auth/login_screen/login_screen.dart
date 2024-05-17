import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/provider/authenticaton/auth.dart';
import 'package:techno_news/screen/auth/register_screen/register_screen.dart';
import 'package:techno_news/shared_widgets/buttons/button_widget.dart';
import 'package:techno_news/shared_widgets/buttons/social_button_widget.dart';
import 'package:techno_news/shared_widgets/textfields/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.onNavigationChange})
      : super(key: key);
  final Function onNavigationChange;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffff6f8fa),
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: width,
                height: height / 2.2,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg/b1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo/logo1.png',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Relevant - Comprehensive - Informative',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                margin: EdgeInsets.only(
                  top: height / 2.6,
                  bottom: 15,
                  left: 15,
                  right: 15,
                ),
                width: width - 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Log In",
                      style: TextStyle(
                        color: Color(0xfff092547),
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Color(0xfff6c7278),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.onNavigationChange();
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xfff4d81e7),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFieldWidget(
                      label: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      label: 'Password',
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color(0xfff4d81e7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                        onPressed: () async {
                          await context
                              .read<AuthController>()
                              .loginWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                        },
                        title: 'Log In'),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width / 3.5,
                          height: 2,
                          color: const Color(0xfffedf1f3),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Or",
                          style: TextStyle(
                            color: Color(0xfff6c7278),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: width / 3.5,
                          height: 2,
                          color: const Color(0xfffedf1f3),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SocialButtonWidget(
                      label: 'Continue with Google',
                      socialType: 'google',
                      onTap: () async {
                        await context
                            .read<AuthController>()
                            .continueWithGoogle();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SocialButtonWidget(
                      label: 'Continue with Facebook',
                      socialType: 'fb',
                      onTap: () async {
                        await context
                            .read<AuthController>()
                            .continueWithFacebook();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
