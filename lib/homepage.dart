import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              if( await googleSignIn.isSignedIn()) {
              await googleSignIn.disconnect();
              };
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('login');
            },
          ),
        ],
      ),
      body:  Center(
          child : Text("Welcome!")
      ),
    );
  }
}
