import 'package:bmi_tracker/core/styles/app_text.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/bmi_cubit.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/bmi_state.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/home_cubit.dart';
import 'package:bmi_tracker/features/home/presentation/cubit/home_state.dart';
import 'package:bmi_tracker/features/home/presentation/screens/bmi.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final values = [10.0, 14.0];

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
            height: 260,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(12),
            ),
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 30,

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
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
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
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
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
                            const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
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
                        (data[i]?.bmi ?? 0).clamp(0, 30),
                      ),
                    ),
                    isCurved: true,
                    barWidth: 3,
                    dotData: FlDotData(show: true),

                    gradient: const LinearGradient(
                      colors: [Color(0xFF22D3EE), Color(0xFF10B981)],
                    ),

                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF22D3EE).withOpacity(0.3),
                          const Color(0xFF10B981).withOpacity(0.05),
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
