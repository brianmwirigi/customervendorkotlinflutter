import 'package:customervendorkotlinflutter/providers/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingTabScreen extends StatefulWidget {
  @override
  State<ShippingTabScreen> createState() => _ShippingTabScreenState();
}

class _ShippingTabScreenState extends State<ShippingTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool? _chargeShipping = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
    Provider.of<ProductProvider>(context);
    return Column(
      children: [
        CheckboxListTile(
          title: const Text(
            'Charge Shipping',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          value: _chargeShipping,
          onChanged: (value) {
            setState(() {
              _chargeShipping = value;
              _productProvider.getFormData(chargeShipping: value);
            });
          },
        ),
        if (_chargeShipping == true)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Shipping Fee in Kes';
                }
                return null;
              },
              onChanged: (value) {
                _productProvider.getFormData(shippingFee: int.parse(value));
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Shipping Fee in Kes',
                hintText: '500',
              ),
            ),
          ),
      ],
    );
  }
}
