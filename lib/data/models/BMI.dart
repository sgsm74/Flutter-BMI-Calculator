import 'dart:convert';
import 'dart:math';

import 'package:bmi_calculator/constants/constants.dart';
import 'package:flutter/services.dart';

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
    double bmi = this.weight / pow(this.height, 2);
    return bmi * 10000;
  }

  calculateBMIResult() async {
    double bmi = this.calculateBMI();

    String type = this.age <= 20
        ? await calculateForChild(bmi, this.gender, this.age)
        : typeOfBMI(bmi);

    String description = "";
    String range = this.age <= 20
        ? await calculateRange(this.gender, this.age)
        : "18.5 - 25";

    Map<String, String> data = {
      "BMI": bmi.toStringAsFixed(1),
      "Type": type,
      "Description": description,
      "range": range
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
      result = "دارای اضافه وزن";
    else if (bmi > 30.0 && bmi < 34.9)
      result = "نسبتا چاق";
    else if (bmi > 35.0 && bmi < 39.9)
      result = "به شدت چاق";
    else if (bmi > 40.0) result = "چاقی مفرط";

    return result;
  }

  Future<String> calculateForChild(double bmi, Gender gender, int age) async {
    if (gender == Gender.male) {
      return this.calculateForBoys(bmi, age);
    } else {
      return this.calculateForGirls(bmi, age);
    }
  }

  Future<String> calculateForBoys(double bmi, int age) async {
    Map<String, dynamic> data = jsonDecode(await getJson("boy"));
    String result = '';

    // ignore: non_constant_identifier_names
    String _5percentages = data[age.toString()][0]["5"];
    // ignore: non_constant_identifier_names
    String _85percentages = data[age.toString()][0]["85"];
    // ignore: non_constant_identifier_names
    String _95percentages = data[age.toString()][0]["95"];

    if (bmi < double.parse(_5percentages)) {
      result = "کم وزن";
    } else if (bmi >= double.parse(_5percentages) &&
        bmi < double.parse(_85percentages)) {
      result = "نرمال";
    } else if (bmi >= double.parse(_85percentages) &&
        bmi < double.parse(_95percentages)) {
      result = "دارای اضافه وزن";
    } else {
      result = "چاق";
    }
    return result;
  }

  Future<String> calculateForGirls(double bmi, int age) async {
    Map<String, dynamic> data = jsonDecode(await getJson("girl"));
    String result = '';

    // ignore: non_constant_identifier_names
    String _5percentages = data[age.toString()][0]["5"];
    // ignore: non_constant_identifier_names
    String _85percentages = data[age.toString()][0]["85"];
    // ignore: non_constant_identifier_names
    String _95percentages = data[age.toString()][0]["95"];
    if (bmi < double.parse(_5percentages)) {
      result = "کم وزن";
    } else if (bmi >= double.parse(_5percentages) &&
        bmi < double.parse(_85percentages)) {
      result = "نرمال";
    } else if (bmi >= double.parse(_85percentages) &&
        bmi < double.parse(_95percentages)) {
      result = "دارای اضافه وزن";
    } else {
      result = "چاق";
    }
    return result;
  }

  Future<String> getJson(String gender) {
    return gender == "boy"
        ? rootBundle.loadString('assets/boys-data.json')
        : rootBundle.loadString('assets/girls-data.json');
  }

  Future<String> calculateRange(Gender gender, int age) async {
    Map<String, dynamic> data = gender == Gender.male
        ? jsonDecode(await getJson("boy"))
        : jsonDecode(await getJson("girl"));

    // ignore: non_constant_identifier_names
    String _5percentages = data[age.toString()][0]["5"];
    // ignore: non_constant_identifier_names
    String _85percentages = data[age.toString()][0]["85"];
    return _5percentages + " - " + _85percentages;
  }
}
