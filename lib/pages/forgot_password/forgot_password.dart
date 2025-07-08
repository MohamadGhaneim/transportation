// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:transportation/communication/send_email.dart';
import 'package:transportation/components/app_elevated_button.dart';
import 'package:transportation/components/app_text_field.dart';
import 'package:transportation/styles/app_colors.dart';
import 'package:transportation/validation/input_validation.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final Email_forgotpassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.lightGray,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 20,
                shadowColor: AppColors.lightOrange,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),

                  child: Column(
                    children: [
                      Text("Forgot your Password ?"),
                      SizedBox(height: 24),
                      AppTextField(
                        hint: "Email",
                        icon: const Icon(Icons.email),
                        controller: Email_forgotpassword,
                      ),
                      SizedBox(height: 24),
                      AppElevatedButton(
                        onPressed: () async {
                          String pass = InputValidation.RandomPassword();
                          await SendEmail(
                            context: context,
                            toEmail: Email_forgotpassword.text,
                            newpassword: pass,
                            newhashpassword: InputValidation.hashPassword(pass),
                          );
                          InputValidation.CleanInput(Email_forgotpassword);
                        },
                        text: "Send !",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
