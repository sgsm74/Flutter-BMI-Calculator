import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/presentation/screens/home_screen.dart';
import 'package:bmi_calculator/presentation/screens/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff0a0e21), //or set color with: Color(0xFF0000FF)
    //statusBarIconBrightness: Brightness.dark,
    //statusBarBrightness: Brightness.dark, //
    //systemNavigationBarColor: Colors.white,
    //systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(MyApp());
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BmiBloc>(
      create: (context) => BmiBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          //fontFamily: "IRANSans",
          //primaryColor: Colors.white,
          //brightness: Brightness.light,
          //textTheme: TextTheme(bodyText2:TextStyle(color: Colors.white),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xff0a0e21),
          primaryColor: Color(0xff0a0e21),
          fontFamily: "IRANSans",
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xff0a0e21),
          primaryColor: Color(0xff0a0e21),
          fontFamily: "IRANSans",
        ),
        debugShowCheckedModeBanner: false,
        //home: HomeScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/result': (context) => ResultsScreen()
        },
      ),
    );
  }
}
