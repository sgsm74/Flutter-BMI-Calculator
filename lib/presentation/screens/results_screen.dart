import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/presentation/screens/home_screen.dart';
import 'package:bmi_calculator/presentation/widgets/bottom_button.dart';
import 'package:bmi_calculator/presentation/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "محاسبه گر شاخص BMI",
          textDirection: TextDirection.rtl,
        ),
        centerTitle: true,
        //leading: Icon(Icons.arrow_back_ios_new_rounded),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.bottomRight,
              child: Text(
                "نتایج",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          BlocBuilder<BmiBloc, BmiState>(
            builder: (context, state) {
              return Expanded(
                flex: 5,
                child: CustomCard(
                  color: kActiveCardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        state.bmiResult,
                        style: TextStyle(
                          color: Color(0xff24d876),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        state.bmi,
                        style: kBMIStyle,
                      ),
                      Text(
                        "محدوده نرمال شاخص BMI مناسب سن شما :",
                        textDirection: TextDirection.rtl,
                        style: kBodyTextStyle,
                      ),
                      Text(
                        state.range + " kg/m2",
                        style: kBodyTextStyle,
                      ),
                      Text(
                        state.description,
                        style: kBodyTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          BottomButton(
            title: "محاسبه مجدد",
            onPress: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
