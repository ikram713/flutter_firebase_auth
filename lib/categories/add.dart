import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/customtextfieldadd.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();

  CollectionReference categories = FirebaseFirestore.instance.collection('categories');

  Future<void> addCategory() {
  return categories
      .add({
        "name": name.text,
      })
      .then((value) {
        print("Category Added");
        Navigator.of(context).pushReplacementNamed('homepage');
      })
      .catchError((error) {
        print("Failed to add category: $error");
      });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextFormAdd(
              hintText: "your category name",
              mycontroller: name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a category name";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  addCategory();
                }
              },
              color: Colors.orange,
              textColor: Colors.white,
              child: const Text('Add Category'),
            )
          ],
        ),
      ),
    );
  }
}
