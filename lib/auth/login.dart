import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_firebase/components/textformfield.dart';
import 'package:flutter_firebase/components/customlogoauth.dart';
import 'package:flutter_firebase/components/custombuttonauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) {
    // The user canceled the sign-in
    return ;
  }
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

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
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Login to continue to the app",
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),

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

              InkWell(

                onTap: () async{
                  if (emailController.text.isEmpty) {
                    showDialogBox(
                      type: DialogType.warning,
                      title: "Input Error",
                      desc: "Please enter your email.",
                    );
                    return;
                  }
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: emailController.text.trim(),
                    );
                  } catch (e) {
                    showDialogBox(
                      type: DialogType.error,
                      title: "Error",
                      desc: e.toString(),
                    );
                    return;
                  }

                },
                child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 10),
                  alignment: Alignment.topRight,
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),

          CustomButtonAuth(
            onPressed: () async {
              final email = emailController.text.trim();
              final password = passwordController.text.trim();

              if (email.isEmpty || password.isEmpty) {
                showDialogBox(
                  type: DialogType.warning,
                  title: "Input Error",
                  desc: "Email and password cannot be empty.",
                );
                return;
              }

              try {
                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                final user = credential.user;

                if (user != null && !user.emailVerified) {
                  // Send verification email only once
                  await user.sendEmailVerification();

                  showDialogBox(
                    type: DialogType.info,
                    title: "Email Not Verified",
                    desc: "A verification link has been sent to your email. Please verify before logging in.",
                  );
                  return;
                }

                // Success dialog
                showDialogBox(
                  type: DialogType.success,
                  title: "Login Successful",
                  desc: "Welcome back!",
                  onOk: () {
                    Navigator.of(context).pushReplacementNamed('homepage');
                  },
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  showDialogBox(
                    type: DialogType.error,
                    title: "User Not Found",
                    desc: "No account found with that email.",
                  );
                } else if (e.code == 'wrong-password') {
                  showDialogBox(
                    type: DialogType.error,
                    title: "Wrong Password",
                    desc: "The password entered is incorrect.",
                  );
                } else {
                  showDialogBox(
                    type: DialogType.error,
                    title: "Login Failed",
                    desc: e.message ?? "An unknown error occurred.",
                  );
                }
              }
            },
            backgroundColor: Colors.orange,
            text: "Login",
            textColor: Colors.white,
          ),

          const SizedBox(height: 20),

          Text(
            "Or Login with",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonAuth(
                onPressed: () {
                  signInWithGoogle().then((userCredential) {
                    if (userCredential.user != null) {
                      Navigator.of(context).pushReplacementNamed('homepage');
                    }
                  }).catchError((error) {
                    showDialogBox(
                      type: DialogType.error,
                      title: "Google Sign-In Failed",
                      desc: error.toString(),
                    );
                  });
                },
                backgroundColor: Colors.red.withOpacity(0.1),
                iconColor: Colors.red,
                icon: FontAwesomeIcons.google,
              ),
              CustomButtonAuth(
                onPressed: () {},
                backgroundColor: Colors.black.withOpacity(0.1),
                iconColor: Colors.black,
                icon: Icons.apple,
              ),
              CustomButtonAuth(
                onPressed: () {},
                backgroundColor: Colors.blue.withOpacity(0.1),
                iconColor: Colors.blue,
                icon: Icons.facebook,
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('signup');
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
    );
  }
}
