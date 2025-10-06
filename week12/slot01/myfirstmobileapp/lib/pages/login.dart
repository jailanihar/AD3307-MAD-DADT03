import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfirstmobileapp/components/my_scaffold.dart';
import 'package:myfirstmobileapp/components/my_text_form_field.dart';
import 'package:myfirstmobileapp/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({
    super.key
  });

  @override
  State<LoginPage> createState() =>
    _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController =
    TextEditingController();
  final TextEditingController passwordController =
    TextEditingController();

  String _errorMsg = '';
  bool _showPassword = false;
  String name = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: AppLocalizations.of(context)!.loginPage,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextFormField(
              labelText: AppLocalizations.of(context)!.email,
              controller: usernameController,
            ),
            SizedBox(height: 20),
            MyTextFormField(
              labelText: AppLocalizations.of(context)!.password,
              controller: passwordController,
              obscureText: !_showPassword,
            ),
            SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.showPasswordSwitch),
            Switch(
              value: _showPassword,
              onChanged: (value) {
                setState(() {
                  _showPassword = value;
                });
              }
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential user =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: usernameController.text,
                      password: passwordController.text
                  );
                  if(user.user != null) {
                    DocumentReference userDoc =
                      FirebaseFirestore.instance.collection('users')
                        .doc(user.user!.uid);
                    DocumentSnapshot userSnapshot = await userDoc.get();
                    setState(() {
                      name = userSnapshot.get('name');
                      address = userSnapshot.get('address');
                    });
                  }
                  setState(() {
                    _errorMsg = 'Able to login as $name $address';
                  });
                } on FirebaseAuthException catch (e) {
                  setState(() {
                    _errorMsg = 'Unable to login';
                  });
                }
                // if(usernameController.text == 'admin' 
                //   && passwordController.text == 'admin') {
                //   Navigator.pushReplacementNamed(
                //     context, 
                //     '/myfirstpage'
                //   );
                // } else {
                //   setState(() {
                //     _errorMsg = 'Invalid credential';
                //   });
                // }
              },
              child: Text(AppLocalizations.of(context)!.loginButton)
            ),
            Text(_errorMsg),
          ],
        ),
      ),
    );
  }
}