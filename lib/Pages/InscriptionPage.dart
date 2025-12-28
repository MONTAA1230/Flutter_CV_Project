import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cv_app/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InscriptionPage extends StatelessWidget {
  InscriptionPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDBF4FF),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/avatar.png"),
              radius: 50,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF9195FF),
                        labelText: "Full Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty!';
                        }
                        return null;
                      },
                    ),
                  ),
                  ///////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF9195FF),
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty!';
                        }
                        return null;
                      },
                    ),
                  ),
                  ///////////////////////////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF9195FF),
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is empty!';
                        }
                        return null;
                      },
                    ),
                  ),
                  ///////////////////////////////////////////////////////////////
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("Already have an account? Log in"),
                  ),
                  ///////////////////////////////////////////////////////////////
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUp();
                          print("Full Name: ${_fullNameController.text}");
                          print("Email: ${_emailController.text}");
                          print("Password: ${_passwordController.text}");
                        }
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim(),
          );

      User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_emailController.text.toLowerCase().trim())
            .set({'Full Name': _fullNameController.text.trim()});
      }
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
    }
  }
}
