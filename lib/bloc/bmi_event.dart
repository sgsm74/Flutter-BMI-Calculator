part of 'bmi_bloc.dart';

@immutable
abstract class BmiEvent {
  const BmiEvent();
}

/* class BMIIncreaseHeight extends BmiEvent {
  final int height;
  const BMIIncreaseHeight(this.height);

  @override
  String toString() => 'BMIIncreaseHeight { height: $height }';
}

class BMIDecreaseHeight extends BmiEvent {
  final int height;
  const BMIDecreaseHeight(this.height);

  @override
  String toString() => 'BMIDecreaseHeight { height: $height }';
}


class BMIIncreaseWeight extends BmiEvent {
  final int weight;
  const BMIIncreaseWeight(this.weight);

  @override
  String toString() => 'BMIIncreaseWeight { weight: $weight }';
}

class BMIDecreaseWeight extends BmiEvent {
  final int weight;
  const BMIDecreaseWeight(this.weight);

  @override
  String toString() => 'BMIDecreaseWeight { weight: $weight }';
}


class BMIGenderSelect extends BmiEvent {
  final Gender gender;
  const BMIGenderSelect(this.gender);

  @override
  String toString() => 'BMIGenderSelect { gender: $gender }';
}


class BMIIncreaseAge extends BmiEvent {
  final int age;
  BMIIncreaseAge(this.age);

  @override
  String toString() => 'BMIIncreaseAge { age: $age }';
}

*/

class BMICalculate extends BmiEvent {
  final int age;
  final int height;
  final int weight;
  final Gender gender;
  BMICalculate(this.age, this.height, this.weight, this.gender);

  @override
  String toString() =>
      'BMICalculate { age: $age , height: $height, weight: $weight, gender: $gender}';
}
