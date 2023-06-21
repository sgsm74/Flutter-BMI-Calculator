part of 'bmi_bloc.dart';

@immutable
abstract class BmiEvent {
  const BmiEvent();
}

class BMICalculate extends BmiEvent {
  const BMICalculate(this.age, this.height, this.weight, this.gender);
  final int age;
  final int height;
  final int weight;
  final Gender gender;

  @override
  String toString() =>
      'BMICalculate { age: $age , height: $height, weight: $weight, gender: $gender}';
}
