import 'package:flutter/material.dart';
import 'package:shopping_cart/models/product_model.dart';

class Cart {
  final List<Product> products;
  final int id;
  final String image;
  final String name;
  final String description;
  final double price;
  final Color color;
  double totalPrice;
  int quantity;

  Cart({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
    required this.products,
    required this.totalPrice,
    this.quantity = 1,
  });
}
