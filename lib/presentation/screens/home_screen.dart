import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/constants/constants.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Gender selectedGender = Gender.male;
  int height = 160, weight = 70, age = 22;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final cardColor = theme.cardColor;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'BMI شما چنده؟',
          textDirection: TextDirection.rtl,
          style: theme.appBarTheme.titleTextStyle!.copyWith(fontFamily: 'IRANSans'),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
        centerTitle: theme.appBarTheme.centerTitle,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مشخصات شما',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textDirection: TextDirection.rtl,
            ),
            Row(
              spacing: 16,
              children: [
                GenderTile(
                  label: 'آقا',
                  icon: Icons.male,
                  isSelected: selectedGender == Gender.male,
                  onTap: () => setState(() => selectedGender = Gender.male),
                  primaryColor: primaryColor,
                  cardColor: cardColor,
                ),
                GenderTile(
                  label: 'خانم',
                  icon: Icons.female,
                  isSelected: selectedGender == Gender.female,
                  onTap: () => setState(() => selectedGender = Gender.female),
                  primaryColor: primaryColor,
                  cardColor: cardColor,
                ),
              ],
            ),
            ValueCard(
              label: 'قد',
              value: '$height سانتی‌متر',
              cardColor: cardColor,
              textColor: textColor,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Slider(
                  value: height.toDouble(),
                  min: 120,
                  max: 220,
                  activeColor: primaryColor,
                  onChanged: (val) => setState(() => height = val.toInt()),
                  year2023: false,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CounterCard(
                    label: 'وزن',
                    value: '$weight کیلوگرم',
                    onAdd: () {
                      setState(() => weight++);
                    },
                    onRemove: () {
                      setState(() => weight > 10 ? weight-- : null);
                    },
                    cardColor: cardColor,
                    textColor: textColor,
                    primaryColor: primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CounterCard(
                    label: 'سن',
                    value: '$age سال',
                    onAdd: () {
                      setState(() => age < 120 ? age++ : null);
                    },
                    onRemove: () {
                      setState(() => age > 3 ? age-- : null);
                    },
                    cardColor: cardColor,
                    textColor: textColor,
                    primaryColor: primaryColor,
                  ),
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
                BlocProvider.of<BmiBloc>(context).add(
                  BMICalculate(age, height, weight, selectedGender),
                );
                Navigator.pushNamed(context, '/result');
              },
              icon: const Icon(Icons.calculate),
              label: const Text('محاسبه BMI'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderTile extends StatelessWidget {
  const GenderTile({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.primaryColor,
    required this.cardColor,
  });
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color primaryColor;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, size: 64, color: isSelected ? onPrimary : primaryColor),
              const SizedBox(height: 10),
              Text(
                label,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: isSelected ? onPrimary : primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ValueCard extends StatelessWidget {
  const ValueCard({
    super.key,
    required this.label,
    required this.value,
    required this.child,
    required this.cardColor,
    required this.textColor,
  });
  final String label;
  final String value;
  final Widget child;
  final Color cardColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500, color: textColor)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
          child,
        ],
      ),
    );
  }
}

class CounterCard extends StatelessWidget {
  const CounterCard({
    super.key,
    required this.label,
    required this.value,
    required this.onAdd,
    required this.onRemove,
    required this.cardColor,
    required this.textColor,
    required this.primaryColor,
  });
  final String label;
  final String value;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final Color cardColor;
  final Color textColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500, color: textColor)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: onAdd, icon: Icon(Icons.add_circle_outline, color: primaryColor, size: 32)),
              IconButton(onPressed: onRemove, icon: Icon(Icons.remove_circle_outline, color: primaryColor, size: 32)),
            ],
          ),
        ],
      ),
    );
  }
}
