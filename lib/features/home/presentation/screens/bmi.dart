import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_button.dart';
import 'package:bmi_tracker/features/auth/widgets/custom_form_field.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/home_cubit.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/home_state.dart';
import 'package:bmi_tracker/features/home/presentation/widgets/my_bar_graph.dart';
import 'package:bmi_tracker/features/profile/data/model/profile_model.dart';
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
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [FancyLineChart()],
        );
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
}
