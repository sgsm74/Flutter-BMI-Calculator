import 'package:bmi_calculator/constants/constants.dart';
import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  GenderCard({required this.label, required this.icon});
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80,
          color: label == "آقا" ? Colors.blueAccent : kBottomContainerColor,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        ),
      ],
    );
  }
}
