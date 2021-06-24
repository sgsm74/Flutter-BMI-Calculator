import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/data/dataproviders/BMIProvider.dart';
import 'package:bmi_calculator/data/models/BMI.dart';

class BMIRepository {
  final BMIProvider bmiProvier = BMIProvider();

  Future<Map<String, String>> getBMIResults(
      int weight, int height, int age, Gender gender) async {
    BMI bmi = bmiProvier.getBMICalculationResult(gender, height, weight, age);
    return await bmi.calculateBMIResult();
  }
}
