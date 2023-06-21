import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/data/dataproviders/bmi_provider.dart';
import 'package:bmi_calculator/data/models/bmi.dart';

class BMIRepository {
  final BMIProvider bmiProvier = BMIProvider();

  Future<Map<String, String>> getBMIResults(
    int weight,
    int height,
    int age,
    Gender gender,
  ) async {
    Bmi bmi = bmiProvier.getBMICalculationResult(gender, height, weight, age);
    return await bmi.calculateBMIResult();
  }
}
