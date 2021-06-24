part of 'bmi_bloc.dart';

@immutable
class BmiState {
  final String bmi;
  final String bmiResult;
  final String description;
  final String range;

  const BmiState(
      {required this.bmi,
      required this.bmiResult,
      required this.description,
      required this.range});
}
