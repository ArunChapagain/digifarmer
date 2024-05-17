import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('This the the test for the font style ',
              style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
    );
  }
}
