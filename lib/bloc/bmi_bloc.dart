import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/data/repositories/BMIRepository.dart';
import 'package:meta/meta.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc()
      : super(BmiState(bmi: '', bmiResult: '', description: "", range: ""));

  final BMIRepository repo = BMIRepository();
  @override
  Stream<BmiState> mapEventToState(
    BmiEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is BMICalculate) {
      final results = await repo.getBMIResults(
          event.weight, event.height, event.age, event.gender);
      //await Future.delayed(Duration(seconds: 10));
      yield BmiState(
          bmi: results['BMI']!,
          bmiResult: results['Type']!,
          description: results['Description']!,
          range: results['range']!);
    }
  }
}
