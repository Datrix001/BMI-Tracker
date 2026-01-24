import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_button.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_form_field.dart';
import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';
import 'package:bmi_tracker/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bmi_tracker/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditBMi extends StatefulWidget {
  const EditBMi({super.key});
  static const routeName = "/edit-bmi";

  @override
  State<EditBMi> createState() => _EditBMiState();
}

class _EditBMiState extends State<EditBMi> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  final user = Supabase.instance.client.auth.currentUser;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    if (user?.id != null) {
      context.read<ProfileCubit>().getUserTodayData(user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileTodayDataLoadedSuccess && _isSaving) {
          _isSaving = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: appTextB1("Profile Data Update Successfully")),
          );
          context.pop();
        }
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: appTextB1(state.errorMessage)));
          print(state.errorMessage);
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is ProfileTodayDataLoadedSuccess) {
            final profile = state.model;
            weightController.text = profile?.weight.toString() ?? '';
            heightController.text = profile?.height.toString() ?? '';
          }
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: true,
              title: appTextS1("Edit Today's BMI"),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(right: 42.w, left: 42.w, top: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                    child: appTextB1("Enter your weight"),
                  ),
                  CustomFormField(
                    hintText: "Enter your Weight",
                    isPassword: false,
                    controller: weightController,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                    child: appTextB1("Enter your height"),
                  ),
                  CustomFormField(
                    hintText: "Enter Your Height",
                    isPassword: false,
                    controller: heightController,
                  ),

                  20.verticalSpace,
                  CustomButton(
                    onPressed: () => onClicked(),
                    buttonText: "Save",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onClicked() {
    if (weightController.text.isEmpty || heightController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: appTextB1("Please fill all fields")));
      return;
    }
    final bmi =
        (double.parse(weightController.text) /
        (double.parse(heightController.text) *
            double.parse(heightController.text)));

    final editProfileModel = BmiModel(
      bmi: bmi,
      weight: double.parse(weightController.text),
      height: double.parse(heightController.text),
      userid: user!.id,
    );

    context.read<ProfileCubit>().sendData(editProfileModel);
  }
}
