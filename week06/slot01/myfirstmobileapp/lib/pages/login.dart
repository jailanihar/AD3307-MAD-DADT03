import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfirstmobileapp/components/my_scaffold.dart';
import 'package:myfirstmobileapp/components/my_text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Login Page',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextFormField(
              labelText: 'Username',
              controller: usernameController,
            ),
            SizedBox(height: 20),
            MyTextFormField(
              labelText: 'Password',
              controller: passwordController,
              obscureText: !_showPassword,
            ),
            SizedBox(height: 20),
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
                  // await FirebaseAuth.instance.signInWithEmailAndPassword(
                  //   email: usernameController.text,
                  //   password: passwordController.text
                  // );
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: usernameController.text,
                    password: passwordController.text
                  );
                  setState(() {
                    _errorMsg = 'Able to login';
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
              child: Text('Login')
            ),
            Text(_errorMsg),
          ],
        ),
      ),
    );
  }
}