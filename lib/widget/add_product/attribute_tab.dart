import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zedeverything_vendor/provider/product_provider.dart';

class AttributeTab extends StatefulWidget {
  const AttributeTab({super.key});

  @override
  State<AttributeTab> createState() => _AttributeTabState();
}

class _AttributeTabState extends State<AttributeTab>with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive=>true;

  final List<String> _sizeList = [];
  final _sizeText = TextEditingController();
  bool? _saved = false;
  bool _entered = false;
  String? selectedUnit;
  List<String> _units = [
    'Kg',
    'g',
    'Ltr',
    'Nos',
    'Ml',
    'Feet',
    'Set'
  ];

  Widget _formField({String? label,
    TextInputType? inputType,
    void Function(String)? onChanged,
    int? minLine, int? maxLine
  }) {
    return TextFormField(
      keyboardType: inputType,
      decoration: InputDecoration(
        label: Text(label!),
      ),
      onChanged: onChanged,
      minLines: minLine,
      maxLines: maxLine,
    );
  }

  Widget _unitDropDown(ProductProvider provider){
    return DropdownButtonFormField<String>(
      value: selectedUnit,
      hint: const Text('Select unit', style: TextStyle(fontSize: 16),),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      onChanged: (String? newValue) {
        // This is called when the user selects an item.
        setState(() {
          selectedUnit = newValue!;
          provider.getFormData(
              unit: newValue
          );
        });
      },
      items: _units.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      validator: (value){
        if(value!.isEmpty){
          return 'Select unit';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<ProductProvider>(builder: (context,provider,_){
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _formField(
                label:'Brand',
                inputType: TextInputType.text,
                onChanged: (value){
                  provider.getFormData(
                    brand: value,
                  );
                }
            ),
            _unitDropDown(provider),
            Row(
              children: [
                Expanded(
                child: TextFormField(
                  controller: _sizeText,
                  decoration: InputDecoration(
                    label: Text('Size')
                  ),
                  onChanged: (value){
                    if(value.isNotEmpty){
                      setState(() {
                        _entered = true;
                      });
                    }
                  },
                ),
                ),
                if(_entered)
                ElevatedButton(
                  child: Text('Add'),
                  onPressed: (){
                    setState(() {
                      _sizeList.add(_sizeText.text);
                      _sizeText.clear();
                      _entered = false;
                      _saved = false;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 10,),
            if(_sizeList.isNotEmpty)
            SizedBox(
              height: 50,
              width: 50,
              child: ListView.builder(
                shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _sizeList.length,
                  itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onLongPress: (){
                      setState(() {
                        _sizeList.removeAt(index);
                        provider.getFormData(
                          sizeList: _sizeList
                        );
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.blueGrey.shade400,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text(_sizeList[index], style: TextStyle(fontWeight: FontWeight.bold),)),
                      ),
                    ),
                  ),
                );
              }),
            ),
            if(_sizeList.isNotEmpty)
            Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                    child: Text('* long press to delete', style: TextStyle(color: Colors.grey,fontSize: 12),)),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(_saved == true? 'Saved' : 'Save'),
                        onPressed: (){
                          setState(() {
                            provider.getFormData(
                                sizeList: _sizeList
                            );
                            _saved = true;
                          });
                        }, ),
                    ),
                  ],
                ),
              ],
            ),
            _formField(
              label: 'Add other details',
              maxLine: 2,
              onChanged: (value){
                provider.getFormData(
                  otherDetails: value
                );
              }
            )
          ],
        ),
      );
    });
  }
}
