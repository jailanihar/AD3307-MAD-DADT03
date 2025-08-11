import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  const MyTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  State<MyTextFormField> createState() =>
    _MyTextFormFieldState();

}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          // padding: const EdgeInsets.all(20.0),
          // padding: const EdgeInsets.symmetric(horizontal: 20.0),
          padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
          child: Text(widget.labelText),
        ),
        SizedBox(height: 12),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}