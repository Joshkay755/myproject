import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:zedeverything_vendor/screens/landing_screen.dart';
import 'package:zedeverything_vendor/screens/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String id= 'login-screen';
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    action == AuthAction.signIn
                        ? 'Welcome to ZedEverything-Vendor! Please sign in to continue.'
                        : 'Welcome to ZedEverything-Vendor! Please create an account to continue',
                  ),
                );
              },
              footerBuilder: (context, _) {
                return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'By signing in, you agree to our terms and conditions.',
                    style: TextStyle(color: Colors.grey),textAlign: TextAlign.center,
                  ),
                );
              },
              headerBuilder: (context, constraints, _) {
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: AspectRatio(
                    aspectRatio: 0.1,
                    child: Center(
                        child: Column(
                          children:const [
                            Text('ZEDEVERYTHING', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, letterSpacing: -1, height: 3),textAlign: TextAlign.center, ),
                            Text('Vendor', style: TextStyle(fontSize: 22, height: -1 ),)
                      ],
                    )),
                  ),
                );
              },
              providers: [
                EmailAuthProvider(),
                GoogleProvider(clientId: '1:997509411455:android:c43add86d6429320f6054a'),
                PhoneAuthProvider(),
              ]
          );
        }// Render your application if authenticated
        return LandingScreen();
      },
    );
  }
}

