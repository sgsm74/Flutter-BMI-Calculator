import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/data/dataproviders/BMIProvider.dart';
import 'package:bmi_calculator/data/models/BMI.dart';

class BMIRepository {
  final BMIProvider bmiProvier = BMIProvider();

  Map<String, String> getBMIResults(
      int weight, int height, int age, Gender gender) {
    BMI bmi = bmiProvier.getBMICalculationResult(gender, height, weight, age);
    return bmi.calculateBMIResult();
  }
}
