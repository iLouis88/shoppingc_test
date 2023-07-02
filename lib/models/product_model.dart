import 'package:flutter/material.dart';

class Product {
  final int id;
  final String image;
  final String name;
  final String description;
  final double price;
  final Color color;
  int quantity;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
    this.quantity = 1,
  });
}
