part of 'bmi_bloc.dart';

@immutable
class BmiState {
  final String bmi;
  final String bmiResult;
  final String description;

  const BmiState(
      {required this.bmi, required this.bmiResult, required this.description});
}
