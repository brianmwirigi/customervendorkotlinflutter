import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';

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

  String? _selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        iconTheme: IconThemeData(
          color: Colors.green,
        ),
        title: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                widget.productData['productName'].toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                    fontSize: 30),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 70),
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
                        itemCount:
                            widget.productData['productImageUrlList'].length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _productImageIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 5)),
                                  child: Image.network(
                                      widget.productData['productImageUrlList']
                                          [index]),
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
                          widget.productData['productPrice'].toStringAsFixed(0),
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
                          fontSize: 20,
                          letterSpacing: 5,
                          fontWeight: FontWeight.bold),
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
                      'Product Nutrition Value: ',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      widget.productData['productNutritionValue'],
                      style: const TextStyle(
                          fontSize: 20,
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
                      fontSize: 20,
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
                      formattedDate(
                          widget.productData['productScheduleDate'].toDate()),
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
                      itemCount: widget.productData['productSizeList'].length,
                      itemBuilder: (context, index) {
                        return OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _selectedSize =
                                  widget.productData['productSizeList'][index];
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                widget.productData['productSizeList'][index] ==
                                        _selectedSize
                                    ? Colors.green
                                    : Colors.white,
                            side: BorderSide(
                                color: _selectedSize ==
                                        widget.productData['productSizeList']
                                            [index]
                                    ? Colors.green
                                    : Colors.black),
                          ),
                          child: Text(
                            widget.productData['productSizeList'][index],
                            style: const TextStyle(
                                fontSize: 20,
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 100,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(CupertinoIcons.shopping_cart, size: 30, color: Colors.white),
              Text(
                'ADD TO CART',
                style: TextStyle(
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
    );
  }
}
