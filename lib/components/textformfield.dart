import 'package:flutter/material.dart';


class CustomTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController mycontroller;

  const CustomTextForm({super.key ,required, required this.hintText, required this.mycontroller});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: mycontroller  ,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 15,
                )
              ),
    );
  }
}







 