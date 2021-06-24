import 'dart:math';

import 'package:bmi_calculator/constants/constants.dart';

class BMI {
  int weight;
  int height;
  int age;
  Gender gender;

  BMI({
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
  });

  double calculateBMI() {
    double bmi = this.weight / pow(height, 2);
    return bmi * 10000;
  }

  calculateBMIResult() {
    double bmi = this.calculateBMI();
    String type = typeOfBMI(bmi);
    String description = "";
    Map<String, String> data = {
      "BMI": bmi.toStringAsFixed(1),
      "Type": type,
      "Description": description
    };
    return data;
  }

  String typeOfBMI(double bmi) {
    String result = '';
    if (bmi < 16.0)
      result = "کم وزنی شدید";
    else if (bmi > 16.0 && bmi < 18.4)
      result = "کم وزن";
    else if (bmi > 18.5 && bmi < 24.9)
      result = "نرمال";
    else if (bmi > 25.0 && bmi < 29.9)
      result = "چاق";
    else if (bmi > 30.0 && bmi < 34.9)
      result = "نسبتا چاق";
    else if (bmi > 35.0 && bmi < 39.9)
      result = "به شدت چاق";
    else if (bmi > 40.0) result = "چاقی مفرط";

    return result;
  }
}
