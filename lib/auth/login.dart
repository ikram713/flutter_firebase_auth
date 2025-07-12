import 'package:flutter/material.dart';
import 'package:flutter_firebase/components/textformfield.dart';
import 'package:flutter_firebase/components/customlogoauth.dart';
import 'package:flutter_firebase/components/custombuttonauth.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Login to continu to the app",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),

                // Email
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CustomTextForm(
                  hintText: "Enter your email",
                  mycontroller: emailController,
                ),

                // Password
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

            // Login button
            CustomButtonAuth(
              onPressed: () {
                // TODO: Handle login
              },
              backgroundColor: Colors.orange,
              text: "Login",
              textColor: Colors.white,
            ),

            const SizedBox(height: 20),

            // OR
            Text(
              "Or Login with ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.grey[600]),
            ),

            const SizedBox(height: 20),

            // Social buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Google
                CustomButtonAuth(
                  onPressed: () {
                    // TODO: Google sign-in
                  },
                  backgroundColor: Colors.red.withOpacity(0.1),
                  iconColor: Colors.red,
                  icon: Icons.mail_outline,
                ),

                // Apple
                CustomButtonAuth(
                  onPressed: () {
                    // TODO: Apple sign-in
                  },
                  backgroundColor: Colors.black.withOpacity(0.1),
                  iconColor: Colors.black,
                  icon: Icons.apple,
                ),

                // Facebook
                CustomButtonAuth(
                  onPressed: () {
                    // TODO: Facebook sign-in
                  },
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  iconColor: Colors.blue,
                  icon: Icons.facebook,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Sign up prompt
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('signup');
                  },
                  child: const Text(
                    "Sign Up",
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


