import 'package:flutter/material.dart';
import 'package:transportation/components/app_text_field.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/pages/login/login_api.dart';
import 'package:transportation/styles/app_colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkGray,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              //padding: EdgeInsets.only(top: screenHeight * 0.08),
              child: Image.asset(
                'assets/images/b.png',
                fit: BoxFit.contain,
                width: double.infinity,
                height: screenHeight * 0.35,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.04,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Login", style: TextStyle(fontSize: screenWidth * 0.06)),

                  ////////////////////////////////////////////////////
                  SizedBox(height: screenHeight * 0.02),
                  AppTextField(
                    hint: "Email",
                    icon: Icon(Icons.email),
                    controller: emailController,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  AppTextField(
                    hint: "Password",
                    icon: Icon(Icons.lock),
                    controller: passwordController,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                    height: screenHeight * 0.06,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepOrange,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        LoginAPI.handleLogin(
                          context: context,
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  ////////////////////////////////////////////////////////////////////////////
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.lightGray)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Text(
                          "Or login with",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(child: Divider(color: AppColors.lightGray)),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/google.png',
                            width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.05),
                      SizedBox(
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/facebook.png',
                            width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.signup);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: AppColors.deepOrange),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
