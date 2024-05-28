import 'package:customervendorkotlinflutter/providers/customercartprovider.dart';
import 'package:customervendorkotlinflutter/views/customers/innerscreens/productcheckoutscreen.dart';
import 'package:customervendorkotlinflutter/views/customers/maincustomerscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CustomerCartProvider _customerCartProvider =
        Provider.of<CustomerCartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Center(
          child: Text(
            'CARTS',
            style: TextStyle(
              fontSize: 30,
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        actions: _customerCartProvider.getCartItem.isNotEmpty
            ? [
                Center(
                  child: Container(
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            _customerCartProvider.clearCart();
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            : [],
      ),
      body: Column(
        children: [
          Expanded(
            child: _customerCartProvider.getCartItem.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: _customerCartProvider.getCartItem.length,
                    itemBuilder: (context, index) {
                      final cartData = _customerCartProvider.getCartItem.values
                          .toList()[index];
                      return Card(
                        child: SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.network(
                                    cartData.productImageUrl[0],
                                    fit: BoxFit.contain),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Product Name: ',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          cartData.productName,
                                          style: const TextStyle(fontWeight: FontWeight.bold,),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Product Category: ',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          cartData.productCategory.toString(),
                                          style: const TextStyle(fontWeight: FontWeight.bold,),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Product Price: ',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'kes ${cartData.productPrice.toStringAsFixed(0)}',
                                          style: const TextStyle(fontWeight: FontWeight.bold,),
                                        ),
                                      ],
                                    ),
                                    const Row(children: [
                                      Text(
                                        'Product Size: ',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ]),
                                    OutlinedButton(
                                      onPressed: null,
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.red, width: 2),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            cartData.productSize.toString(),
                                            style:
                                                const TextStyle(fontWeight: FontWeight.bold,),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed:
                                                    cartData.productQuantity ==
                                                            1
                                                        ? null
                                                        : () {
                                                            _customerCartProvider
                                                                .productQuantityDecrement(
                                                                    cartData);
                                                          },
                                                icon: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                  cartData.productQuantity
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                              IconButton(
                                                onPressed: cartData
                                                            .cartProductQuantity ==
                                                        cartData.productQuantity
                                                    ? null
                                                    : () {
                                                        _customerCartProvider
                                                            .productQuantityIncrement(
                                                                cartData);
                                                      },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            String productKey =
                                                cartData.productId +
                                                    cartData.productSize;
                                            _customerCartProvider
                                                .removeItemFromCart(productKey);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 50,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          textAlign: TextAlign.center,
                          'No Items in Shopping Cart',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Icon(
                          Icons.shopping_cart,
                          size: 50,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const MainCustomerScreen();
                              }));
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'CONTINUE SHOPPING',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _customerCartProvider.getCartItem.isNotEmpty
                ? InkWell(
                    onTap: _customerCartProvider.totalCartPrice == 0
                        ? null
                        : () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const ProductCheckoutScreen();
                            }));
                          },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        color: _customerCartProvider.totalCartPrice == 0
                            ? Colors.grey
                            : Colors.green,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Total Amount: kes ${_customerCartProvider.totalCartPrice}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'CHECKOUT',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
