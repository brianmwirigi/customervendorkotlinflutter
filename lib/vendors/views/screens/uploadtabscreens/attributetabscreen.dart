import 'package:customervendorkotlinflutter/providers/productprovider.dart';
import 'package:customervendorkotlinflutter/utilities/showsnackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributeTabScreen extends StatefulWidget {
  @override
  State<AttributeTabScreen> createState() => _AttributeTabScreenState();
}

class _AttributeTabScreenState extends State<AttributeTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final TextEditingController _sizeController = TextEditingController();
  bool _sizeEntered = false;

  final List<String> _sizeList = [];

  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter product Dietary Fibre Value per 100 gram\'s';
              }
              return null;
            },
            onChanged: (value) {
              _productProvider.getFormData(productNutritionValue: value);
            },
            decoration: const InputDecoration(
              labelText: 'Enter Product Dietary Fibre per 100 grams',
              hintText: 'example: 5 grams',
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 200,
                  child: TextFormField(
                    controller: _sizeController,
                    onChanged: (value) {
                      setState(() {
                        _sizeEntered = true;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter Product size',
                      hintText: 'example: 1kg',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              _sizeEntered == true
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);
                          _sizeController.clear();
                        });
                        mySnackBar(context, 'Size added');
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : const Text(''),
            ],
          ),
          const SizedBox(height: 20.0),
          if (_sizeList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _sizeList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _sizeList.removeAt(index);
                          _productProvider.getFormData(
                              productSizeList: _sizeList);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              _sizeList[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (_sizeList.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                _productProvider.getFormData(productSizeList: _sizeList);
                setState(() {
                  _isSave = true;
                });
              },
              child: Text(
                _isSave ? 'Saved' : 'Save',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 4),
              ),
            ),
        ],
      ),
    );
  }
}
