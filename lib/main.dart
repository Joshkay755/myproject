import 'package:date_time_format/date_time_format.dart';
import 'package:finalproject_admin/screens/category_screen.dart';
import 'package:finalproject_admin/screens/dashboard_screen.dart';
import 'package:finalproject_admin/screens/main_category_screen.dart';
import 'package:finalproject_admin/screens/sub_category_screen.dart';
import 'package:finalproject_admin/screens/vendors_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finalproject Admin',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade300),
      ),
      home: const SideMenu(),
      builder: EasyLoading.init(),
    );
  }
}


class SideMenu extends StatefulWidget {
  static const String id = 'side-menu';
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  Widget _selectedScreen = const DashBoardScreen();

  screenSelector(item){
    switch(item.route){
      case DashBoardScreen.id:
        setState((){
        _selectedScreen = const DashBoardScreen();
        });
        break;
      case CategoryScreen.id:
        setState((){
          _selectedScreen = const CategoryScreen();
        });
        break;
      case MainCategoryScreen.id:
        setState((){
          _selectedScreen = const MainCategoryScreen();
        });
        break;
      case SubCategoryScreen.id:
        setState((){
          _selectedScreen = const SubCategoryScreen();
        });
        break;
      case VendorsScreen.id:
        setState((){
          _selectedScreen = const VendorsScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('ZedEverything Admin', style: TextStyle(letterSpacing: 1),),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashBoardScreen.id,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: IconlyLight.category,
            children: [
              AdminMenuItem(
                title: 'Category',
                route: CategoryScreen.id,
              ),
              AdminMenuItem(
                title: 'Main Category',
                route: MainCategoryScreen.id,
              ),
              AdminMenuItem(
                title: 'Sub Category',
                route: SubCategoryScreen.id,
              ),

            ],
          ),
          AdminMenuItem(
            title: 'Vendors',
            route: VendorsScreen.id,
            icon: Icons.group_outlined,
          ),
        ],
        selectedRoute: SideMenu.id,
        onSelected: (item) {
          screenSelector(item);
          /*if (item.route != null) {
            Navigator.of(context).pushNamed(item.route!);
          }*/
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: Center(
            child: Text(
              DateTimeFormat.format(DateTime.now(), format: AmericanDateTimeFormats.dayOfWeek),
              style:  TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _selectedScreen,
      ),
    );
  }
}



