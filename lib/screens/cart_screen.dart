import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/widgets/cart_card.dart';
import '../colors.dart';
import '../models/product_model.dart';
import '../provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).loadCart().then((_) {
      print(
          'Cart loaded successfully: ${Provider.of<CartProvider>(context, listen: false).products}');
    }).catchError((error) {
      print('Error loading cart: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.products;
    final total = cartProvider.totalPrice;

    return Scaffold(
      backgroundColor:white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        title: Container(
            margin: const EdgeInsets.only(
              left: 27,
            ),
            child: const Text('Cart',
                style: TextStyle(
                  color: black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ))),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 27, top: 15, bottom: 15),
            child: Text(
              '\$$total',
              style: const TextStyle(
                color: black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(

            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) => CartCard(product: cartItems[index]),
            ),
          ),

        ],
      ),
    );
  }
}
