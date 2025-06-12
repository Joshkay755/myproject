
import 'dart:async';

import 'package:finalproject/screens/main_screen.dart';
import 'package:finalproject/screens/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Lato'
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id:(context)=>const SplashScreen(),
        OnBoardingScreen.id : (context)=>const OnBoardingScreen(),
        MainScreen.id : (context)=>const MainScreen(),
      },
    );
  }
}



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id ='splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final store = GetStorage();

  @override
  void initState(){
    Timer(const Duration(
        seconds: 3 //first 3 seconds will show app logo and will move to on board screen
    ),(){
      bool? boarding= store.read('onBoarding');
      boarding == null ?Navigator.pushReplacementNamed(context, OnBoardingScreen.id) :
      boarding == true ? Navigator.pushReplacementNamed(context, MainScreen.id) :
      Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,overlays: []);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/logo 2.png"),
      ),
    );
  }
}




