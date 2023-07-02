import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../colors.dart';
import '../models/product_model.dart';
import '../provider/cart_provider.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isAddedToCart = false;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    await cartProvider.loadCart(); // đợi cho hàm loadCart hoàn tất
    setState(() {
      isAddedToCart = cartProvider.isProductInCart(widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: widget.product.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Image.network(
            widget.product.image,
            height: 380,
            width: 305,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 37),
        Text(
          widget.product.name,
          style: const TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: black),
        ),
        const SizedBox(height: 37),
        SizedBox(
          width: 305,
          child: Text(
            widget.product.description,
            style: const TextStyle(fontSize: 12.50, color: grey),
          ),
        ),
        const SizedBox(height: 45),
        SizedBox(
          width: 320,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$${widget.product.price}',
                style: const TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: black),
              ),
              const SizedBox(
                width: 80,
              ),
              SizedBox(
                height: 45,
                width: 122,
                child: isAddedToCart
                    ? const Icon(Icons.done, color: Colors.green)
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(yellow),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30.0), // Thay đổi bán kính
                            ),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'ADD TO CART',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11.88, fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () {
                          CartProvider cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          cartProvider.addProduct(widget.product);
                          setState(() {
                            isAddedToCart = true;
                          });
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
