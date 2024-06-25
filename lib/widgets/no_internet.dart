import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Icon(
            Icons.wifi_off,
            size: 100,
            color: Color(0xFF5A5656),
          ),
          Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF5A5656),
            ),
          ),
        ],
      ),
    );
  }
}
