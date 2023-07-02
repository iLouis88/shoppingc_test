import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import '../models/product_model.dart';
import '../provider/cart_provider.dart';

class CartCard extends StatefulWidget {
  final Product product;

  const CartCard({Key? key, required this.product}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
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
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 20,
              ),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: widget.product.color,
                child: Transform.rotate(
                  angle: -0.5236,
                  child: Image.network(
                    widget.product.image,
                    height: 89,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Text('\$${widget.product.price * widget.product.quantity}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 10),
                Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 20.0,
                        child: const Icon(Icons.remove, size: 12, color: black),
                      ),
                      onPressed: () {
                        cartProvider.updateProductQuantity(
                            widget.product, widget.product.quantity - 1);
                      },
                    ),
                    Text(widget.product.quantity.toString()),
                    IconButton(
                      icon: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 20.0,
                        child: const Icon(Icons.add, size: 12, color: black),
                      ),
                      onPressed: () {
                        cartProvider.updateProductQuantity(
                            widget.product, widget.product.quantity + 1);
                      },
                    ),
                    const SizedBox(width: 53),
                    IconButton(
                      icon: const CircleAvatar(
                        backgroundColor: yellow,
                        radius: 20.0,
                        child: Icon(Icons.delete_outline_rounded, size: 15, color: black),

                      ),
                      onPressed: () {
                        cartProvider.removeProduct(widget.product);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
