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
      body: Center(
        child: ListView(
          children: [
            if(Navigator.canPop(context))
              ElevatedButton(
                onPressed: () {
                  if(Navigator.canPop(context)) {
                    Navigator.pop(context);
                    // Navigator.of(context).pop();
                  }
                },
                child: const Icon(Icons.arrow_back),
              ),
            body,
          ],
        )
      ),
      drawer: Drawer(
        backgroundColor: Colors.lightGreenAccent,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('First Page'),
              onTap: () {
                Navigator.of(context).pushNamed('/myfirstpage');
              }
            ),
            ListTile(
              leading: const Icon(Icons.person_2),
              title: const Text('Second Page'),
              onTap: () {
                Navigator.of(context).pushNamed('/mysecondpage');
              }
            ),
            ListTile(
              leading: const Icon(Icons.person_3),
              title: const Text('Third Page'),
              onTap: () {
                Navigator.of(context).pushNamed('/mythirdpage');
              }
            ),
          ],
        ),
      ),
    );
  }
}