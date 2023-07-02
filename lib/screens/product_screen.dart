import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/screens/product_screen.dart';

import '../colors.dart';
import '../models/product_model.dart';
import '../provider/product_provider.dart';
import '../widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
/*
 // Add dữ liệu sản phẩm lên firestore từ Product Provider
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ProductProvider productData =
    Provider.of<ProductProvider>(context, listen: false);
    List<Product> products = productData.products;
    productData.addProducts(products);
  }*/

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            child: const Text(
              'Our Products',
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
      body: Container(
        width: 370,
        height: 650,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: FutureBuilder<List<Product>>(
          future: productProvider.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = snapshot.data!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Column(
                    children: [
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 82),
                        child: ProductCard(product: product),
                      )),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
