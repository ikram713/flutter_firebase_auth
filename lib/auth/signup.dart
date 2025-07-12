import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/textformfield.dart';
import 'package:flutter_firebase/components/customlogoauth.dart';
import 'package:flutter_firebase/components/custombuttonauth.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
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
                  "Signup to continu to the app",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),

                // Email
                const Text(
                  "Name",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextForm(
                  hintText: "Enter your Name",
                  mycontroller: nameController,
                ),

                // Password
                const SizedBox(height: 10),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextForm(
                  hintText: "Enter your email",
                  mycontroller: emailController,
                ),
                const SizedBox(height: 10),
                  const Text(
                  "Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextForm(
                  hintText: "Enter your password",
                  mycontroller: passwordController,
                ),

                // Forgot password
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.topRight,
                  child: const Text(
                    "forgot password?",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),

            // Signup button
            CustomButtonAuth(
              onPressed: () {
                // TODO: Handle Signup
              },
              backgroundColor: Colors.orange,
              text: "Signup",
              textColor: Colors.white,
            ),

            const SizedBox(height: 20),

            // OR

            const SizedBox(height: 20),


            const SizedBox(height: 20),

            // Sign up prompt
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                InkWell(
                    onTap: () {
                    Navigator.of(context).pushNamed('login');
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
      ),
    );
  }
}
