// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:transportation/components/app_elevated_button.dart';
import 'package:transportation/components/app_text_field.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/pages/login/login_api.dart';
import 'package:transportation/pages/login/login_with_google.dart';
import 'package:transportation/styles/app_colors.dart';
import 'package:transportation/validation/input_validation.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkGray,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // HEADER IMAGE
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/b.png',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: screenHeight * 0.3,
                      ),
                    ),

                    // LOGIN CONTAINER
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.08,
                          vertical: screenHeight * 0.035,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.offWhite,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // TITLE
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: screenWidth * 0.065,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),

                            // EMAIL
                            AppTextField(
                              hint: "Email",
                              icon: const Icon(Icons.email),
                              controller: emailController,
                            ),
                            SizedBox(height: screenHeight * 0.02),

                            // PASSWORD
                            AppTextField(
                              hint: "Password",
                              icon: const Icon(Icons.lock),
                              controller: passwordController,
                              obscureText: true,
                            ),

                            // FORGOT PASSWORD
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed:
                                    () => Navigator.of(
                                      context,
                                    ).pushNamed(AppRoutes.forgotpassword),

                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),

                            // LOGIN BUTTON
                            AppElevatedButton(
                              onPressed: () async {
                                LoginAPI.handleLogin(
                                  context: context,
                                  email: emailController.text.trim(),
                                  password: InputValidation.hashPassword(
                                    passwordController.text.trim(),
                                  ),
                                );
                              },
                              text: "Login",
                            ),

                            SizedBox(height: screenHeight * 0.025),

                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(color: Colors.grey),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02,
                                  ),
                                  child: const Text("or login with"),
                                ),
                                const Expanded(
                                  child: Divider(color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            //login with google
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: screenWidth * 0.13,
                                  height: screenWidth * 0.13,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      handleSignIn(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Image.asset(
                                      'assets/images/google.png',
                                      width: screenWidth * 0.07,
                                    ),
                                  ),
                                ),

                                SizedBox(width: screenWidth * 0.04),

                                // SizedBox(
                                //   width: screenWidth * 0.13,
                                //   height: screenWidth * 0.13,
                                //   child: ElevatedButton(
                                //     onPressed: () {},
                                //     style: ElevatedButton.styleFrom(
                                //       padding: EdgeInsets.zero,
                                //       backgroundColor: Colors.white,
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(16),
                                //       ),
                                //     ),
                                //     child: Image.asset(
                                //       'assets/images/facebook.png',
                                //       width: screenWidth * 0.07,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),

                            const Spacer(),

                            // SIGN UP
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(
                                        context,
                                      ).pushNamed(AppRoutes.signup),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: AppColors.deepOrange,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
