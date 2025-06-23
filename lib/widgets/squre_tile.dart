import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final Function() onTap;
  final String imgUrl;
  const SquareTile({super.key, required this.imgUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        ),
        child: Row(
          spacing: 20,
          children: [
            Image.asset(
              imgUrl,
              height: 40,
              // colorFilter: ColorFilter.mode(palette.white, BlendMode.srcIn),
              // color: Colors.grey[300],
              colorBlendMode: BlendMode.srcOut,
            ),
            Text(
              "Sign in with Google",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
