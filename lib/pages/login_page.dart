import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chatapp/pages/sign_in_page.dart';
import 'package:firebase_chatapp/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

import '../common_widgets/button_field.dart';
import '../common_widgets/text_fields.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.laptop_mac_outlined,
                    size: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome back you've been missed!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFields(
                    hintText: "Email",
                    controller: emailController,
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFields(
                    hintText: "Password",
                    controller: passwordController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonFields(
                    text: "Sign In",
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await authService.signInWithEmailAndPassword(

                          emailController.text,
                          passwordController.text,
                        );
                      } catch (e) {
                        print("Error during sign in: $e");
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member? ",
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) {
                        //         return SigninPage();
                        //       },
                        //     ),
                        //   );
                        // },
                        child: Text(
                          "Register now",
                          style: TextStyle(
                            // fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  )
                  // RichText(
                  //     text: TextSpan(text: "Already a member", children: [
                  //   TextSpan(
                  //       onEnter: (event) {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) {
                  //               return SigninPage();
                  //             },
                  //           ),
                  //         );
                  //       },
                  //       text: "Login noe"),
                  // ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
