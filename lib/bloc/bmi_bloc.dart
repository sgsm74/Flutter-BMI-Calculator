import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/data/repositories/BMIRepository.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc({required this.repo})
      : super(
          const BmiState(
            bmi: '',
            bmiResult: '',
            description: '',
            range: '',
          ),
        ) {
    on<BmiEvent>((event, emit) async {
      if (event is BMICalculate) {
        await _onBMICalculate(event, emit);
      }
    });
  }
  final BMIRepository repo;

  _onBMICalculate(BMICalculate event, Emitter<BmiState> emit) async {
    final results = await repo.getBMIResults(
      event.weight,
      event.height,
      event.age,
      event.gender,
    );
    emit(
      BmiState(
        bmi: results['BMI']!,
        bmiResult: results['Type']!,
        description: results['Description']!,
        range: results['range']!,
      ),
    );
  }
}
