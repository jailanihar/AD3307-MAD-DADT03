import 'package:flutter/material.dart';
import 'package:myfirstmobileapp/components/my_scaffold.dart';

class MyThirdPage extends StatelessWidget {
  const MyThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'My Third Page',
      body: Column(
        children: [
          const Text('This is the body of third page'),
          ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed('/myhomepage');
                Navigator.of(context)
                  .pushNamedAndRemoveUntil(
                    '/myhomepage',
                    (Route<dynamic> route) => false
                  );
              },
              child: const Text('Go To Home Page'),
            ),
        ],
      ),
    );
  }
}