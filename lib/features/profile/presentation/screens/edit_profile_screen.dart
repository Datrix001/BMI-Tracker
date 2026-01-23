import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_button.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const routeName = "/edit-profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: appTextS1("Edit Profile"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(right: 42.w, left: 42.w, top: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appTextB1("Enter your email"),
            10.verticalSpace,
            CustomFormField(
              hintText: "example@gmail.com",
              isPassword: false,
              controller: emailController,
            ),

            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
              child: appTextB1("Enter your Name"),
            ),

            CustomFormField(
              hintText: "John Doe",
              isPassword: false,
              controller: nameController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
              child: appTextB1("Enter your weight"),
            ),
            CustomFormField(
              hintText: "70kg",
              isPassword: false,
              controller: weightController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
              child: appTextB1("Enter your height"),
            ),
            CustomFormField(
              hintText: "185cm",
              isPassword: false,
              controller: heightController,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
              child: appTextB1("Enter your gender"),
            ),
            CustomFormField(
              hintText: "Male",
              isPassword: false,
              controller: genderController,
            ),
            20.verticalSpace,
            CustomButton(onPressed: () {}, buttonText: "Save"),
          ],
        ),
      ),
    );
  }
}
