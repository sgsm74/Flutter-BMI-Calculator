import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/data/repositories/bmi_repository.dart';
import 'package:bmi_calculator/firebase_options.dart';
import 'package:bmi_calculator/presentation/screens/home_screen.dart';
import 'package:bmi_calculator/presentation/screens/results_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff0a0e21), //or set color with: Color(0xFF0000FF)
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BmiBloc>(
      create: (context) => BmiBloc(repo: BMIRepository()),
      child: MaterialApp(
        title: 'BMI Calculator',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xff0a0e21),
          primaryColor: const Color(0xff0a0e21),
          fontFamily: 'IRANSans',
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xff0a0e21),
          primaryColor: const Color(0xff0a0e21),
          fontFamily: 'IRANSans',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/result': (context) => const ResultsScreen(),
        },
      ),
    );
  }
}
