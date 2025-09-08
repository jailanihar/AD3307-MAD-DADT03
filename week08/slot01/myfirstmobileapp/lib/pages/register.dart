import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myfirstmobileapp/components/my_scaffold.dart';
import 'package:myfirstmobileapp/components/my_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  
  String _errorMsg = '';
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: 'Register Page',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextFormField(
              labelText: 'Email',
              controller: emailController
            ),
            MyTextFormField(
              labelText: 'Password',
              controller: passwordController,
              obscureText: !_showPassword,
            ),
            MyTextFormField(
              labelText: 'Name',
              controller: nameController
            ),
            MyTextFormField(
              labelText: 'Address',
              controller: addressController
            ),
            Switch(
              value: _showPassword,
              onChanged: (value) {
                setState(() {
                  _showPassword = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  UserCredential user = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text
                  );
                  // print(user.user!.uid); // Get the UID of registered user
                  if(user.user != null) {
                    DocumentReference userDoc =
                      FirebaseFirestore.instance.collection('users')
                      .doc(user.user!.uid);
                    userDoc.set(
                      {
                        'name': nameController.text,
                        'address': addressController.text,
                      }
                    );
                  }
                } on Exception catch (_) {
                  setState(() {
                    _errorMsg = 'Unable to register';
                  });
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}