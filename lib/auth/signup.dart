import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_firebase/components/textformfield.dart';
import 'package:flutter_firebase/components/customlogoauth.dart';
import 'package:flutter_firebase/components/custombuttonauth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void showDialogBox({
    required DialogType type,
    required String title,
    required String desc,
    VoidCallback? onOk,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.rightSlide,
      title: title,
      desc: desc,
      btnOkOnPress: onOk ?? () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomLogoAuth(),
              const SizedBox(height: 20),
              const Text(
                "Signup",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Signup to continue to the app",
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),

              const Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              CustomTextForm(
                hintText: "Enter your name",
                mycontroller: nameController,
              ),

              const SizedBox(height: 10),
              const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              CustomTextForm(
                hintText: "Enter your email",
                mycontroller: emailController,
              ),

              const SizedBox(height: 10),
              const Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              CustomTextForm(
                hintText: "Enter your password",
                mycontroller: passwordController,
              ),

              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                alignment: Alignment.topRight,
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),

          CustomButtonAuth(
            onPressed: () async {
              final email = emailController.text.trim();
              final password = passwordController.text.trim();
              final name = nameController.text.trim();

              if (email.isEmpty || password.isEmpty || name.isEmpty) {
                showDialogBox(
                  type: DialogType.warning,
                  title: "Missing Fields",
                  desc: "Please fill in all fields.",
                );
                return;
              }

              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );              
                    Navigator.of(context).pushReplacementNamed('login');
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  showDialogBox(
                    type: DialogType.error,
                    title: "Weak Password",
                    desc: "The password provided is too weak.",
                  );
                } else if (e.code == 'email-already-in-use') {
                  showDialogBox(
                    type: DialogType.error,
                    title: "Email Exists",
                    desc: "An account already exists for that email.",
                  );
                } else {
                  showDialogBox(
                    type: DialogType.error,
                    title: "Signup Failed",
                    desc: e.message ?? "An unexpected error occurred.",
                  );
                }
              } catch (e) {
                showDialogBox(
                  type: DialogType.error,
                  title: "Error",
                  desc: e.toString(),
                );
              }
            },
            backgroundColor: Colors.orange,
            text: "Signup",
            textColor: Colors.white,
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('login');
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

