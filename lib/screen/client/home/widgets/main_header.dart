import 'package:flutter/material.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: 50,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF0A2A55),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(29),
          bottomRight: Radius.circular(29),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/logo/main_logo.png'),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'to The Technoscope Publication ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xffEFEFEF),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'The official student publication of \nPangasinan State University - Urdaneta Campus',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xffEFEFEF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
