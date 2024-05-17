import 'package:flutter/material.dart';

class AddMoreImagesWidget extends StatelessWidget {
  const AddMoreImagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xffEFF0F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate_outlined, color: Color(0xff6c7278)),
            SizedBox(
              height: 10,
            ),
            Text(
              'Upload Images',
              style: TextStyle(
                color: Color(0xfff6c7278),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
