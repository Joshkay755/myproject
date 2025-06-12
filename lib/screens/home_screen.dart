import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:finalproject/Widgets/brand_highlights.dart';
import 'package:finalproject/Widgets/category/catergory_widget.dart';
import '../Widgets/banner_widget.dart';



class HomeScreen  extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.blue.shade700,
          title: const Text('ZEDEVERTHING',style:TextStyle(
              letterSpacing: -1,
              color: Colors.white),),
          actions: [
            IconButton(
              icon: const Icon(IconlyLight.bag ),
              onPressed: (){},
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          SearchWidget(),
          SizedBox(height: 10,),
          BannerWidget(),
          BrandHighlights(),
          CatergoryWidget()
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: const TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    hintText: 'Search Item',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(IconlyLight.search, size: 20,
                      color: Colors.black54,)

                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: const [
                  Icon(IconlyLight.infoSquare, size: 12, color: Colors.white,),
                  Text(' 100% Genuine',
                    style: TextStyle(color: Colors.white,fontSize: 12),)
                ],
              ),
              Row(
                children: const [
                  Icon(IconlyLight.infoSquare, size: 12, color: Colors.white,),
                  Text(' 4 - 7 Days Return',
                    style: TextStyle(color: Colors.white,fontSize: 12),)
                ],
              ),
              Row(
                children: const [
                  Icon(IconlyLight.infoSquare, size: 12, color: Colors.white,),
                  Text('Trusted Brands',
                    style: TextStyle(color: Colors.white,fontSize: 12),)
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}