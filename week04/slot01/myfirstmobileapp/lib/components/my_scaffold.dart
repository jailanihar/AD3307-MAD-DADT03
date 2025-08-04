import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const MyScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.limeAccent,
      ),
      body: body,
    );
  }
}