import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/data/models/BMI.dart';

class BMIProvider {
  BMI getBMICalculationResult(Gender gender, int height, int weight, int age) {
    BMI bmi = BMI(weight: weight, height: height, age: age, gender: gender);
    return bmi;
  }
}
