import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_news/provider/authenticaton/register_controller.dart';
import 'package:techno_news/screen/auth/login_screen/login_screen.dart';
import 'package:techno_news/shared_widgets/buttons/button_widget.dart';
import 'package:techno_news/shared_widgets/textfields/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
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
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xfff092547),
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Already have an account?",
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Log in",
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
                      label: 'Full Name',
                      controller: fullNameController,
                    ),
                    const SizedBox(
                      height: 10,
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
                    TextFieldWidget(
                      label: 'Confirm Password',
                      controller: passwordConfirmationController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                      onPressed: () async {
                        await context
                            .read<RegisterController>()
                            .createAnAccount(
                                fullName: fullNameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                passwordConfirmation:
                                    passwordConfirmationController.text.trim());
                      },
                      title: 'Register',
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
