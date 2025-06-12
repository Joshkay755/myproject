import 'package:finalproject/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:finalproject/screens/account_screen.dart';
import 'package:finalproject/screens/cart_screen.dart';
import 'package:finalproject/screens/home_screen.dart';
import 'package:finalproject/screens/message_screen.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({this.index, super.key});
  static const String id = 'home-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;


  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoryScreen(),
    MessageScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if(widget.index!=null){
      setState(() {
        _selectedIndex =widget.index!;
      });
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200),
          )
        ),
        child: BottomNavigationBar(
          elevation: 4,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 0 ? IconlyBold.home: IconlyLight.home),
              label: 'Home',
              //backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1 ? IconlyBold.category: IconlyLight.category),
              label: 'Category',
              //backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 2 ? IconlyBold.activity : IconlyLight.activity),
              label: 'Messages',
              //backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 3 ? IconlyBold.buy : IconlyLight.buy),
              label: 'Cart',
              //backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 4 ? IconlyBold.user2 : IconlyLight.user2),
              label: 'Account',
              //backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.grey[800],
          showUnselectedLabels: true,
          unselectedItemColor: Colors.blueGrey[800],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
        ),
      ),
    );
  }
}

