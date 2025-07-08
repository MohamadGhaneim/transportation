// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:transportation/components/app_elevated_button.dart';
import 'package:transportation/components/app_text_field.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/pages/signup/signup_api.dart';
import 'package:transportation/styles/app_colors.dart';
import 'package:transportation/validation/input_validation.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String passwordMessage = "";
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
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          if (value.length < 6) {
                            passwordMessage = "Password is too short";
                          } else if (value.length > 10) {
                            passwordMessage = "Password is too long";
                          } else {
                            passwordMessage = "Password length is valid";
                          }
                        });
                      },
                    ),

                    Text(
                      passwordMessage,
                      style: TextStyle(
                        color:
                            passwordMessage.contains("valid")
                                ? Colors.green
                                : Colors.red,
                        fontSize: 10,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    AppTextField(
                      hint: "Confirm Password",
                      icon: const Icon(Icons.lock),
                      controller: confirmPasswordController,
                      obscureText: true,
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

                    AppElevatedButton(
                      onPressed: () async {
                        await SignupApi.handleSignup(
                          context: context,
                          email: InputValidation.cleanInput(
                            emailController.text.trim(),
                          ),
                          //////////////
                          password: InputValidation.hashPassword(
                            passwordController.text.trim(),
                          ),
                          confirmPassword: InputValidation.hashPassword(
                            confirmPasswordController.text.trim(),
                          ),
                          //////////////////////////
                          phone: InputValidation.cleanPhoneNumber(
                            phoneController.text.trim(),
                          ),
                          fullName: InputValidation.cleanInput(
                            fullNameController.text.trim(),
                          ),
                        );
                        InputValidation.cleanInput(emailController.text);
                        InputValidation.cleanInput(passwordController.text);
                        InputValidation.cleanInput(
                          confirmPasswordController.text,
                        );
                        InputValidation.cleanInput(phoneController.text);
                        InputValidation.cleanInput(fullNameController.text);
                      },
                      text: "SignUp",
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
