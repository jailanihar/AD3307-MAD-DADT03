import 'package:flutter/material.dart';
import 'package:myfirstmobileapp/components/my_scaffold.dart';

class MyThirdPage extends StatelessWidget {
  const MyThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'My Third Page',
      body: const Text('This is the body of third page'),
    );
  }
}