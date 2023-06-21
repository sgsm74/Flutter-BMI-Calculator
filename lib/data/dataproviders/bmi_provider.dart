import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/data/models/bmi.dart';

class BMIProvider {
  Bmi getBMICalculationResult(Gender gender, int height, int weight, int age) {
    Bmi bmi = Bmi(weight: weight, height: height, age: age, gender: gender);
    return bmi;
  }
}
