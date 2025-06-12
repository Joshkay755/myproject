import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject_admin/firebase_service.dart';
import 'package:finalproject_admin/model/vendor_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VendorsList extends StatelessWidget {
  final bool? approveStatus;
  const VendorsList({this.approveStatus, super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();

    Widget vendorData({int? flex, String? text,Widget? widget}){
      return Expanded(
        flex: flex!,
        child: Container(
          height: 66,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget ?? Text(text!),
          ),
        ),
      );
    }
    return StreamBuilder<QuerySnapshot>(
        stream: service.vendor.where('approved',isEqualTo: approveStatus).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          if(snapshot.data!.size==0){
            return Center(child: Text('No Vendors to show', style: TextStyle(fontSize: 22),),);
          }
          return ListView.builder(
            shrinkWrap: true,
              itemCount: snapshot.data!.size,
              itemBuilder: (context,index){
                Vendor vendor = Vendor.fromJson(snapshot.data!.docs[index].data() as Map<String,dynamic>);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  vendorData(
                      flex: 1,
                      widget: Container(
                          height: 50,
                          width: 50,
                          child: Image.network(vendor.logo!),
                      ),
                  ),
                  vendorData(
                    flex: 3,
                    text: vendor.businessName,
                  ),
                  vendorData(
                    flex: 1,
                    text: vendor.city,
                  ),
                  vendorData(
                    flex: 2,
                    text: vendor.state,
                  ),
                  vendorData(
                    flex: 1,
                    widget: vendor.approved==true ? ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.grey.shade700)),
                        child: FittedBox(child: Text('Reject',style: TextStyle(color: Colors.white70),)),
                        onPressed: (){
                          EasyLoading.show();
                          service.updateData(
                              data: {
                                'approved':false
                              },
                              docName: vendor.uid,
                              reference: service.vendor
                          ).then((value){
                            EasyLoading.dismiss();
                          });
                        },
                    ):ElevatedButton(
                        child: FittedBox(child: Text('Approve',style: TextStyle(color: Colors.deepPurple),)),
                        onPressed: (){
                          EasyLoading.show();
                          service.updateData(
                            data: {
                              'approved':true
                            },
                            docName: vendor.uid,
                            reference: service.vendor
                          ).then((value){
                            EasyLoading.dismiss();
                          });
                        }, )
                  ),
                  vendorData(
                    flex: 1,
                    widget: ElevatedButton(
                        child:Text('View More',textAlign: TextAlign.center,),
                        onPressed: (){

                },)
                  )
                ],
              );
              }
          );
        });
  }
}
