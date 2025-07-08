// ignore_for_file: camel_case_types, use_build_context_synchronously, unused_field, unnecessary_this

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportation/components/app_text_field.dart';
import 'package:transportation/components/tool_bar.dart';
import 'package:transportation/components/user_avatar.dart';
import 'package:transportation/config/app_routes.dart';
import 'package:transportation/pages/login/login_class.dart';
import 'package:transportation/pages/profile/profile_api.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

enum profile_select { edit, logout }

class _EditProfilePageState extends State<EditProfilePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  int userID = 0;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profileImagePath', pickedFile.path);
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileInfo();
  }

  Future<void> _loadProfileInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profileImagePath');
    if (path != null && File(path).existsSync()) {
      _profileImage = File(path);
    }

    final user = await User.loadUserFromPrefs();
    if (user != null) {
      emailController.text = user.email;
      phoneController.text = user.phoneNumber;
      fullNameController.text = user.fullName;
      userID = user.userId;
    }

    setState(() {});
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Toolbar(
        title: "myProfile",
        actions: [
          PopupMenuButton(
            iconSize: 35,
            onSelected: (value) async {
              //are you sure you want to logout?

              switch (value) {
                case profile_select.logout:
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          icon: Icon(Icons.warning, color: Colors.amber),
                          title: Text("Confirm Logout"),
                          content: Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text("Yes"),
                            ),
                          ],
                        ),
                  );
                  if (confirm == true) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.pushNamed(context, AppRoutes.login);
                  }
                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: profile_select.logout,
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 10),
                      Text("logout"),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26),
                      child:
                          _profileImage != null
                              ? Image.file(
                                _profileImage!,
                                height: 130,
                                width: 130,
                                fit: BoxFit.cover,
                              )
                              : UserAvatar(height: 130, width: 130),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(color: Colors.black),
              ),
              SizedBox(height: 20),
              SizedBox(height: screenHeight * 0.02),
              AppTextField(
                hint: "Email",
                icon: const Icon(Icons.email),
                controller: emailController,
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
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text("Save"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  backgroundColor: Colors.blueAccent,
                  textStyle: TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  // final prefs = await SharedPreferences.getInstance();
                  // final imagePath = prefs.getString('profileImagePath') ?? "";
                  await ProfileApi.updateProfile(
                    context: context,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                    fullName: fullNameController.text,
                    path_photo: "", // Use default image path,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
