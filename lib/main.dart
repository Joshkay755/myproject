import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zedeverything_vendor/provider/product_provider.dart';
import 'package:zedeverything_vendor/provider/vendor_provider.dart';
import 'package:zedeverything_vendor/screens/add_product_screen.dart';
import 'package:zedeverything_vendor/screens/home_screen.dart';
import 'package:zedeverything_vendor/screens/login_screen.dart';
import 'package:zedeverything_vendor/screens/product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(
      MultiProvider(
        providers: [
          Provider<VendorProvider>(create: (_) => VendorProvider()),
          Provider<ProductProvider>(create: (_) => ProductProvider()),
        ],
        child: MyApp(),
      ),
  );


}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade400,),
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
      routes: {
        HomeScreen.id: (context)=>HomeScreen(),
        ProductScreen.id: (context)=>ProductScreen(),
        AddProductScreen.id: (context)=>AddProductScreen(),
        LoginScreen.id: (context)=>LoginScreen()

      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement (
        context,
        MaterialPageRoute (
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('ZEDEVERYTHING',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500,
              letterSpacing: -1,
              ),
            ),
            Text('Vendor', style: TextStyle(fontSize: 20, ),)
          ],
        ),
      )
    );
  }
}





