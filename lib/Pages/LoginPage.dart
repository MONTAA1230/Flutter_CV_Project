import 'package:cv_app/Pages/InscriptionPage.dart';
import 'package:cv_app/Pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _signinErrorMessage = "";
  bool _rememberMe = false;

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
              backgroundImage: AssetImage("assets/LoginLogo.jpg"),
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          activeColor: Color(0xff41a8f5),
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xff41a8f5)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Text(
                          "Remember Me",
                          style: TextStyle(color: Colors.black),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InscriptionPage(),
                              ),
                            );
                          },
                          child: Text("Don't Have An Account ? "),
                        ),
                      ],
                    ),
                  ),
                  ///////////////////////////////////////////////////////////////
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signIn();
                          print("Email: ${_emailController.text}");
                          print("Password: ${_passwordController.text}");
                        }
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Text(_signinErrorMessage),
                  SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      final TextEditingController emailController =
                          TextEditingController();

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Reset Password"),
                          content: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: "Enter your email",
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),

                            TextButton(
                              onPressed: () async {
                                String email = emailController.text.trim();

                                if (email.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Please enter your email"),
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(email: email);

                                  Navigator.pop(context);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Password reset link sent. Check your email.",
                                      ),
                                    ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  String message = "Something went wrong";

                                  if (e.code == 'user-not-found') {
                                    message =
                                        "No account found with this email";
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                }
                              },
                              child: const Text("Send"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text("Forgot Password ?"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim(), 
          );
      final user = userCredential.user;
      if (user == null) {
        setState(() {
          _signinErrorMessage = "User not found !";
        });
        return;
      }
      if (!user.emailVerified) {
        setState(() {
          _signinErrorMessage = "Email not verified !";
        });
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException {
      setState(() {
        _signinErrorMessage = "Email or password is incorrect !";
      });
    } catch (e) {
      // Catch any null errors or unexpected errors
      print("Unexpected error in login: $e");
    }
  }
}
