import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/presentation/screens/results_screen.dart';
import 'package:bmi_calculator/presentation/widgets/bottom_button.dart';
import 'package:bmi_calculator/presentation/widgets/custom_card.dart';
import 'package:bmi_calculator/presentation/widgets/gender_card.dart';
import 'package:bmi_calculator/presentation/widgets/round_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Gender selectedGender = Gender.male;
  int height = 160;
  int weight = 70;
  int age = 22;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "محاسبه گر شاخص BMI",
          textDirection: TextDirection.rtl,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    color: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    child: GenderCard(
                      label: "آقا",
                      icon: Icons.male,
                    ),
                  ),
                ),
                Expanded(
                    child: CustomCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.female;
                    });
                  },
                  color: selectedGender == Gender.female
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  child: GenderCard(
                    label: "خانم",
                    icon: Icons.female,
                  ),
                )),
              ],
            ),
          ),
          Expanded(
              child: CustomCard(
                  color: kActiveCardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "قد",
                        style: kLabelTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        textDirection: TextDirection.rtl,
                        children: [
                          Text(height.toString(), style: kNumberTextStyle),
                          Text("سانتی متر", style: kLabelTextStyle),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Color(0xff8d8e98),
                            overlayColor:
                                kBottomContainerColor.withOpacity(0.3),
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 15.0,
                            ),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 30),
                            thumbColor: kBottomContainerColor),
                        child: Slider(
                          value: height.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              height = value.toInt();
                            });
                          },
                          min: 120.0,
                          max: 220.0,
                        ),
                      )
                    ],
                  ))),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CustomCard(
                    color: kActiveCardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "وزن",
                          style: kLabelTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(weight.toString(), style: kNumberTextStyle),
                            Text("کیلوگرم", style: kLabelTextStyle),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RoundIconButton(
                              child: Icons.add,
                              onPress: () {
                                setState(() {
                                  weight = weight + 1;
                                });
                              },
                            ),
                            RoundIconButton(
                                child: Icons.remove,
                                onPress: () {
                                  setState(() {
                                    if (weight > 10) weight = weight - 1;
                                  });
                                }),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    color: kActiveCardColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "سن",
                          style: kLabelTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          textDirection: TextDirection.rtl,
                          children: [
                            Text(age.toString(), style: kNumberTextStyle),
                            Text("سال", style: kLabelTextStyle),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RoundIconButton(
                              child: Icons.add,
                              onPress: () {
                                setState(() {
                                  if (age < 120) age = age + 1;
                                  ;
                                });
                              },
                            ),
                            RoundIconButton(
                              child: Icons.remove,
                              onPress: () {
                                setState(() {
                                  if (age > 1) age = age - 1;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
            title: "محاسبه",
            onPress: () {
              BlocProvider.of<BmiBloc>(context).add(
                BMICalculate(age, height, weight, selectedGender),
              );
              Navigator.pushNamed(context, '/result');
              /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResultsScreen()));*/
            },
          )
        ],
      ),
    );
  }
}
