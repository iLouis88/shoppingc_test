import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<Product> _products = [];
  double _totalPrice = 0.0;

  List<Product> get products => _products;
  double get totalPrice => _totalPrice;

  final CollectionReference cartCollection =
  FirebaseFirestore.instance.collection('cart');

  void addProduct(Product product) {
    _products.add(product);
    _totalPrice += product.price;
    saveCart();
    notifyListeners();
  }

  void removeProduct(Product product) {
  _products.remove(product);
  _totalPrice = 0.0;
  for (var item in _products) {
    _totalPrice += item.price * item.quantity;
  }
  saveCart();
  notifyListeners();
}

  void updateProductQuantity(Product product, int quantity) {
    int index = _products.indexWhere((p) => p.name == product.name);
    _totalPrice += (quantity - product.quantity) * product.price;
    _products[index].quantity = quantity;
    saveCart();
    notifyListeners();
  }

  Future<void> saveCart() async {
    Map<String, dynamic> cartData = {
      'products': _products
          .map((product) => {
        'id': product.id,
        'image': product.image,
        'name': product.name,
        'description': product.description,
        'price': product.price,
      'color': '#${product.color.value.toRadixString(16)}',
        'quantity': product.quantity,
      })
          .toList(),
      'totalPrice': _totalPrice,
    };
    await cartCollection.doc('cartData').set(cartData);
  }

  Future<void> loadCart() async {
    DocumentSnapshot snapshot = await cartCollection.doc('cartData').get();
    if (snapshot.exists) {
      Map<String, dynamic> cartData = snapshot.data() as Map<String, dynamic>;
      _products = (cartData['products'] as List)
          .map((productData) => Product(
        id: productData['id'],
        image: productData['image'],
        name: productData['name'],
        description: productData['description'],
        price: productData['price'],
        color: Color(int.parse(productData['color'].substring(1), radix: 16)),
        quantity: productData['quantity'],
      ))
          .toList();
      _totalPrice = cartData['totalPrice'];
      notifyListeners();
    }
  }

  bool isProductInCart(Product product) {
    return _products.any((p) => p.id == product.id);
  }


}

