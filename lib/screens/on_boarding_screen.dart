import 'package:dots_indicator/dots_indicator.dart';
import 'package:finalproject/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingScreen extends StatefulWidget{
  const OnBoardingScreen({super.key});
  static const String id = 'onboard-screen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  double scrollerPosition = 0;
  final store = GetStorage();

  onButtonPressed(context){

    store.write('onBoarding', true);
    return Navigator.pushReplacementNamed(context, MainScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]
    );
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (val){
              setState(() {
                scrollerPosition = val.toDouble();
              });
            },
            children: [
              OnBoardPage(
                boardColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Welcome\nTo\n ZedEverything',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 42,

                      ),
                    ),
                    const Text('Zambia Ecommerce App',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height : 20,),
                    SizedBox(
                        height : 300,
                        width: 300,
                        child: Image.asset('assets/images/onboard11.png')),

                  ],
                ),
              ),

              OnBoardPage(
                boardColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Wide Range of Products\n To Choose From',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    SizedBox(
                        height : 300,
                        width: 300,
                        child: Image.asset('assets/images/onboard2.png')),

                  ],
                ),
              ),


              OnBoardPage(
                boardColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Safe & Secure\n Payments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                        height : 300,
                        width: 300,
                        child: Image.asset('assets/images/onboard3.jpg')),

                  ],
                ),
              ),
              OnBoardPage(
                boardColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Quick & Secure\n Delivery',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                        height : 300,
                        width: 300,
                        child: Image.asset('assets/images/onboard4.jpg')),

                  ],
                ),
              ),

              OnBoardPage(
                boardColumn: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Exclusive Deals & Discounts\n With Vendors',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                        height : 300,
                        width: 300,
                        child: Image.asset('assets/images/onb5.jpg')),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DotsIndicator(
                  dotsCount: 5,
                  position: scrollerPosition,
                  decorator: DotsDecorator(
                    activeColor: Colors.white,

                  ),
                ),
                scrollerPosition == 4 ? Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.white)
                    ),
                    child: const Text('Start Shopping'),
                    onPressed: (){
                      onButtonPressed(context);
                    },
                  ),
                ) :
                TextButton(
                  child: const Text('SKIP TO THE APP >',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onPressed: (){
                    onButtonPressed(context);
                  },
                ),

                const  SizedBox(height: 20,)
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class OnBoardPage extends StatelessWidget {
  final Column? boardColumn;
  const OnBoardPage({super.key, this.boardColumn}); //fn + alt + insert key

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            color: Colors.white,
            child: Center(child: boardColumn),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFF607D8B),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                  topRight: Radius.circular(100),

                ),

              ),
            ),
          ),
        ]
    );
  }
}

