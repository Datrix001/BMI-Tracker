import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_button.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_form_field.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/home_cubit.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/home_state.dart';
import 'package:bmi_tracker/features/home/presentation/widgets/my_bar_graph.dart';
import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});
  static const routeName = "/bmi-screen";

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final user = Supabase.instance.client.auth.currentUser;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bootstrap();
    });
  }

  Future<void> _bootstrap() async {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (session != null) {
        context.read<HomeCubit>().sendProfileData();
      }
    });
    if (!mounted) return;
    if (user?.id != null) {
      context.read<HomeCubit>().getData(user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeDataFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: appTextB1(state.errorMessage)));
          print(state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is HomeDataSuccessfully) {
          final profile = state.model;
          if (profile == null) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(42.w),

              child: Column(
                children: [
                  appTextS1(
                    "Please Enter Today's Height & Weight",
                    textAlign: TextAlign.center,
                  ),

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
            );
          }
          if (state.model != null) {
            final data = state.model;
            return Padding(
              padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FancyLineChart(),
                  20.verticalSpace,

                  appTextS3("Today's Report :"),

                  10.verticalSpace,
                  bmiText(data!.bmi),
                  10.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: bmiColor(data.bmi).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Obese",
                      style: TextStyle(
                        color: bmiColor(data.bmi),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
        return SizedBox.shrink();
      },
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

    context.read<HomeCubit>().sendData(editProfileModel);
  }

  Widget bmiText(double bmi) {
    if (bmi < 18.5) {
      return appTextB1(
        "Your BMI today is ${bmi.toStringAsFixed(1)}. You may need to gain a little weight for optimal health.",
      );
    } else if (bmi < 25) {
      return appTextB1(
        "Your BMI today is ${bmi.toStringAsFixed(1)}. You are within the healthy weight range. Great job!",
      );
    } else if (bmi < 30) {
      return appTextB1(
        "Your BMI today is ${bmi.toStringAsFixed(1)}. A small lifestyle change can make a big difference.",
      );
    } else {
      return appTextB1(
        "Your BMI today is ${bmi.toStringAsFixed(1)}. Consider consulting a healthcare professional for guidance.",
      );
    }
  }

  Color bmiColor(double bmi) {
    if (bmi < 18.5) return AppColors.blue;
    if (bmi < 25) return AppColors.green;
    if (bmi < 30) return AppColors.orange;
    return AppColors.red;
  }
}
