import 'package:flutter/material.dart';
import 'package:myfirstmobileapp/components/my_scaffold.dart';

class MyFirstPage extends StatelessWidget {
  const MyFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'My First Page',
      body: Column(
        children: [
          const Text('This is page body'),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Click Me'),
          ),
        ],
      ),
    );
    // return Text(
    //   'Hello, this is my first page!',
    //   style: TextStyle(
    //     color: Colors.cyan,
    //     fontSize: 24,
    //     fontWeight: FontWeight.bold,
    //   ),
    // );
  }
}