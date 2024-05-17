import 'package:flutter/material.dart';

class SocialButtonWidget extends StatefulWidget {
  const SocialButtonWidget(
      {super.key,
      required this.label,
      required this.socialType,
      required this.onTap});
  final String label;
  final String socialType;
  final Function onTap;
  @override
  State<SocialButtonWidget> createState() => _SocialButtonWidgetState();
}

class _SocialButtonWidgetState extends State<SocialButtonWidget> {
  bool isLoading = false;
  Future<void> handleOnPressed() async {
    setState(() {
      isLoading = true;
    });
    await widget.onTap();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleOnPressed,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffEFF0F6),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: isLoading
              ? const Text(
                  'Loading...',
                  style: TextStyle(
                    color: Color(0xfff1a1c1e),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.socialType == 'google')
                      Image.asset('assets/logo/google.png'),
                    if (widget.socialType == 'fb')
                      Image.asset('assets/logo/fb.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.label,
                      style: const TextStyle(
                        color: Color(0xfff1a1c1e),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
