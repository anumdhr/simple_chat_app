import 'package:firebase_chatapp/services/auth/auth_services.dart';
import 'package:flutter/material.dart';

import '../common_widgets/button_field.dart';
import '../common_widgets/text_fields.dart';

class SigninPage extends StatefulWidget {
  final void Function() onTap;

  const SigninPage({
    super.key,
    required this.onTap,
  });

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

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
                    "Let's create an account for you!",
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
                  TextFields(
                    hintText: "Confirm Password",
                    controller: confirmController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonFields(
                    text: "Sign Up",
                    onPressed: () async {
                      if (passwordController.text != confirmController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Password doesnot match"),
                          ),
                        );
                        return;
                      }
                      AuthService authService = AuthService();
                      try {
                        await authService.signUpWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString(),
                            ),
                          ),
                        );
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
                          "Login Now",
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
