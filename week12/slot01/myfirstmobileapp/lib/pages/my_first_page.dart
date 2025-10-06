import 'package:flutter/material.dart';
import 'package:myfirstmobileapp/components/my_scaffold.dart';
import 'package:myfirstmobileapp/l10n/app_localizations.dart';

class MyFirstPage extends StatelessWidget {
  const MyFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: AppLocalizations.of(context)!.myFirstPage,
      body: Column(
        children: [
          Text(AppLocalizations.of(context)!.myFirstPageBody),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/mysecondpage');
            },
            child: Text(AppLocalizations.of(context)!.goToSecondPageButton),
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