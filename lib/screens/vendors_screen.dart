import 'package:finalproject_admin/widgets/vendors_list.dart';
import 'package:flutter/material.dart';

class VendorsScreen extends StatefulWidget {
  static const String id ='vendors-screen';
  const VendorsScreen({super.key});

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  Widget _rowHeader({int? flex, String? text}){
    return Expanded(flex: flex!,child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700),
          color: Colors.grey.shade500
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text!, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    ));
  }
  bool? selectedButton;
  @override
  Widget build(BuildContext context) {





    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children:  [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Registered Vendors',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(selectedButton==true ? Theme.of(context).primaryColor:Colors.grey.shade700)
                      ),
                      child: Text('Approved',style: TextStyle(color: Colors.white70),),
                        onPressed: (){
                        setState(() {
                          selectedButton=true;
                        });
                        },),
                    SizedBox(width:10),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(selectedButton==false ? Theme.of(context).primaryColor:Colors.grey.shade700)
                      ),
                      child: Text('Not Approved',style: TextStyle(color: Colors.white70),),
                      onPressed: (){
                        setState(() {
                          selectedButton=false;
                        });
                      },),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(selectedButton==null ? Theme.of(context).primaryColor:Colors.grey.shade700)
                      ),
                      child: Text('All',style: TextStyle(color: Colors.white70),),
                      onPressed: (){
                        setState(() {
                          selectedButton=null;
                        });
                      },),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              _rowHeader(flex: 1, text: 'LOGO'),
              _rowHeader(flex: 3, text: 'BUSINESS NAME'),
              _rowHeader(flex: 1, text: 'CITY'),
              _rowHeader(flex: 2, text: 'STATE'),
              _rowHeader(flex: 1, text: 'ACTION'),
              _rowHeader(flex: 1, text: 'VIEW MORE'),
            ],
          ),
          VendorsList(
            approveStatus: selectedButton,
          ),
        ],
      ),
    );
  }
}
