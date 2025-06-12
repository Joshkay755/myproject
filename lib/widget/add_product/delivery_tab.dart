import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zedeverything_vendor/firebase_services.dart';
import 'package:zedeverything_vendor/provider/product_provider.dart';

class DeliveryTab extends StatefulWidget {
  const DeliveryTab ({super.key});

  @override
  State<DeliveryTab> createState() => _DeliveryTabState();
}

class _DeliveryTabState extends State<DeliveryTab>with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive=>true;


  bool? _chargeDelivery = false;
  final FirebaseServices _services = FirebaseServices();
  
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductProvider>(builder: (context, provider, child){
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Charge Delivery? ', style: TextStyle(color: Colors.grey),),
                value: _chargeDelivery,
                onChanged: (value){
                  setState(() {
                    _chargeDelivery = value;
                    provider.getFormData(
                      chargeDelivery: value
                    );
                  });
                }),
            if(_chargeDelivery==true)
              _services.formField(
                label: 'Delivery Charge',
                inputType: TextInputType.number,
                onChanged: (value){
                  provider.getFormData(
                    deliveryCharge: int.parse(value)
                  );
                }
              )
          ],
        ),
      );
    });
  }
}
