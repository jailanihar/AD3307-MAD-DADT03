import 'dart:math';
import 'package:flutter/material.dart';
import 'package:myfirstmobileapp/components/my_scaffold.dart';

class MySecondPage extends StatefulWidget {
  const MySecondPage({super.key});

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  final List<String> names = [
    'Abu', 'Bakar', 'Curi', 'Daging', 'Emak', 'Fatimah', 'Geli', 'Hati'
  ];

  int selectedNameIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'My Second Page',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Aku mau namaku masa ani, ${names[selectedNameIndex]}'
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedNameIndex = Random().nextInt(names.length);
                });
              },
              child: const Text('Tukar namaku'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/mythirdpage');
              },
              child: const Text('Go To Third Page'),
            ),
          ],
        ),
      ),
    );
  }
}