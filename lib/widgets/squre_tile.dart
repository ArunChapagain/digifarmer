import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final Function() onTap;
  final String imgUrl;
  const SquareTile({super.key, required this.imgUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          color: Colors.grey[200],
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: Image.asset(
          imgUrl,
          // colorFilter: ColorFilter.mode(palette.white, BlendMode.srcIn),
          // color: Colors.grey[300],
      
          colorBlendMode: BlendMode.srcOut,
        ),
      ),
    );
  }
}
