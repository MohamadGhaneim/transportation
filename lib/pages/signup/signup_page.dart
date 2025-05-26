import 'package:flutter/material.dart';
import 'package:transportation/components/app_text_field.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/pages/signup/signup_api.dart';
import 'package:transportation/styles/app_colors.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.darkGray,
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: AppColors.darkGray)),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.85,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.04,
              ),
              decoration: const BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.login);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Back to Login"),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.deepOrange,
                      ),
                    ),
                    Text(
                      "SignUp",
                      style: TextStyle(fontSize: screenWidth * 0.06),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    AppTextField(
                      hint: "Email",
                      icon: const Icon(Icons.email),
                      controller: emailController,
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    AppTextField(
                      hint: "Password",
                      icon: const Icon(Icons.lock),
                      controller: passwordController,
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    AppTextField(
                      hint: "Confirm Password",
                      icon: const Icon(Icons.lock),
                      controller: confirmPasswordController,
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    AppTextField(
                      hint: "Phone number",
                      icon: const Icon(Icons.phone),
                      controller: phoneController,
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    AppTextField(
                      hint: "Full Name",
                      icon: const Icon(Icons.person),
                      controller: fullNameController,
                    ),

                    SizedBox(height: screenHeight * 0.04),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          SignupApi.handleSignup(
                            context: context,
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            confirmPassword:
                                confirmPasswordController.text.trim(),
                            phone: phoneController.text.trim(),
                            fullName: fullNameController.text.trim(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepOrange,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.018,
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: screenWidth * 0.04),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
