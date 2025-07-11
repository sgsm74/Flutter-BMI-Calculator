import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        centerTitle: theme.appBarTheme.centerTitle,
        automaticallyImplyLeading: false,
        title: Text(
          'نتیجه BMI شما 🧾',
          textDirection: TextDirection.rtl,
          style: theme.appBarTheme.titleTextStyle!.copyWith(fontFamily: 'IRANSans'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<BmiBloc, BmiState>(
          builder: (context, state) {
            return Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'نتایج شما',
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      if (!isDark)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.bmiResult,
                        style: textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: state.bmiResult.contains('نرمال') ? Colors.green : Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.bmi,
                        style: textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'محدوده نرمال شاخص BMI:',
                        textDirection: TextDirection.rtl,
                        style: textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${state.range} kg/m²',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.description,
                        style: textTheme.bodyMedium?.copyWith(height: 1.6),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.refresh),
                    label: const Text('محاسبه مجدد'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      textStyle: textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
