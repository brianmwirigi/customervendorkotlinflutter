import 'package:customervendorkotlinflutter/providers/customercartprovider.dart';
import 'package:customervendorkotlinflutter/utilities/showsnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _productImageIndex = 0;

  String formattedDate(date) {
    final productOutputDateFormat = DateFormat('dd/MM/yyyy');
    final productOutputDate = productOutputDateFormat.format(date);
    return productOutputDate;
  }

  bool isInCart = false;
  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    final CustomerCartProvider _customerCartProvider =
        Provider.of<CustomerCartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,

        iconTheme: const IconThemeData(
          color: Colors.green,
        ),
        title: Center(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                widget.productData['productName'].toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                    fontSize: 20),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 500,
                          width: double.infinity,
                          child: Center(
                            child: PhotoView(
                                imageProvider: NetworkImage(
                                    widget.productData['productImageUrlList']
                                        [_productImageIndex])),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget
                                  .productData['productImageUrlList'].length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      _productImageIndex = index;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 5)),
                                        child: Image.network(widget.productData[
                                            'productImageUrlList'][index]),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Product Price: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'kes' +
                                ' ' +
                                widget.productData['productPrice']
                                    .toStringAsFixed(0),
                            style: const TextStyle(
                                fontSize: 20,
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Product Category: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            widget.productData['productCategory'].toUpperCase(),
                            style: const TextStyle(
                                letterSpacing: 5, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Dietary Nutrition Value: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            widget.productData['productNutritionValue'],
                            style: const TextStyle(
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    ExpansionTile(
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Product Description',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'View More',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Text(
                          widget.productData['productDescription'],
                          style: const TextStyle(
                            fontSize: 15,
                            letterSpacing: 3,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Product shipping date:',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            formattedDate(widget
                                .productData['productScheduleDate']
                                .toDate()),
                            style: const TextStyle(
                                fontSize: 15,
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    ExpansionTile(
                      title: const Text(
                        'Available sizes',
                        style: TextStyle(fontSize: 20),
                      ),
                      children: [
                        Container(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                widget.productData['productSizeList'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  color: _selectedSize ==
                                          widget.productData['productSizeList']
                                              [index]
                                      ? Colors.green
                                      : Colors.white,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedSize = widget
                                                .productData['productSizeList']
                                            [index];
                                        var productInCart =
                                            _customerCartProvider
                                                .getCartItem[widget
                                                    .productData['productId'] +
                                                _selectedSize!];
                                        if (productInCart != null) {
                                          isInCart = true;
                                        } else {
                                          isInCart = false;
                                        }
                                      });
                                    },
                                    child: Text(
                                      widget.productData['productSizeList']
                                          [index],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          letterSpacing: 5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          if (_selectedSize == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                mySnackBar(context, 'Please select a size'));
                          } else {
                            var productInCart =
                                _customerCartProvider.getCartItem[
                                    widget.productData['productId'] +
                                        _selectedSize!];
                            if (productInCart != null &&
                                productInCart.productQuantity ==
                                    productInCart.cartProductQuantity) {
                              ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                                  context,
                                  'the product '+ widget.productData['productName'] +
                                      ' in the shhopping cart has reached its limit of: ${productInCart.cartProductQuantity}'));
                            } else if (productInCart != null) {
                              _customerCartProvider
                                  .productQuantityIncrement(productInCart);
                              ScaffoldMessenger.of(context).showSnackBar(mySnackBar(
                                  context,
                                  'Quantity of ' +
                                      widget.productData['productName'] +
                                      ' in cart is: ${productInCart.productQuantity + 1}'));
                            } else {
                              _customerCartProvider.addProductToCart(
                                  widget.productData['productId'],
                                  widget.productData['productName'],
                                  widget.productData['productCategory'],
                                  widget.productData['productImageUrlList'],
                                  1,
                                  widget.productData['productQuantity'],
                                  widget.productData['productPrice'],
                                  _selectedSize!,
                                  widget.productData['productScheduleDate'],
                                  widget.productData['vendorId']);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  mySnackBar(
                                      context,
                                    'The product ' + widget.productData['productName'] +
                                          ' has been added to cart with quantity 1'));
                            }
                            setState(() {
                              isInCart = true;
                            });
                          }
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                            color: isInCart ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(CupertinoIcons.shopping_cart,
                                  size: 30, color: Colors.white),
                              Text(
                                isInCart ? 'IN CART' : 'ADD TO CART',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
