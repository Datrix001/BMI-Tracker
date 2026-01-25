import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/core/styles/app_text_style.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/bmi_cubit.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/bmi_state.dart';
import 'package:bmi_tracker/gen/colors.gen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FancyLineChart extends StatefulWidget {
  const FancyLineChart({super.key});

  @override
  State<FancyLineChart> createState() => _FancyLineChartState();
}

class _FancyLineChartState extends State<FancyLineChart> {
  final user = Supabase.instance.client.auth.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user != null) {
        context.read<BmiCubit>().getHistoricalBmiData(user!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BmiCubit, BmiState>(
      listener: (context, state) {
        if (state is BmiFailureState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: appTextB1(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is BmiLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is BmiHistroySuccessState) {
          final data = state.model;

          if (data.isEmpty) {
            return const Center(child: Text("No BMI data"));
          }

          return Container(
            height: 260.h,
            padding: EdgeInsets.all(25.w),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 40,

                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),

                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: AppTextStyles.b2.copyWith(
                          color: AppColors.white.withAlpha(90),
                        ),
                      ),
                    ),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) => Text(
                        value.toInt().toString(),
                        style: AppTextStyles.b2.copyWith(
                          color: AppColors.white.withAlpha(90),
                        ),
                      ),
                    ),
                  ),
                ),

                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (spots) => spots
                        .map(
                          (spot) => LineTooltipItem(
                            spot.y.toStringAsFixed(1),
                            AppTextStyles.b1.copyWith(color: AppColors.black),
                          ),
                        )
                        .toList(),
                  ),
                ),

                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      data.length,
                      (i) => FlSpot(
                        i.toDouble(),
                        (data[i]?.bmi ?? 0).clamp(0, 40),
                      ),
                    ),
                    isCurved: true,
                    barWidth: 3,
                    dotData: FlDotData(show: true),

                    gradient: const LinearGradient(
                      colors: [AppColors.blue, AppColors.green],
                    ),

                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.blue.withOpacity(0.3),
                          AppColors.green.withOpacity(0.05),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
