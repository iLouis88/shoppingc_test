import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/screens/product_screen.dart';

import '../models/product_model.dart';
import '../provider/product_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

      body: Center(
        child: Stack(
          children: [
            Container(
              width: 800,
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 50,),
                    child: Container(
                      height:605,
                        width: 360,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // Điều chỉnh vị trí bóng
                            ),
                          ],
                        ),
                        child: const ProductScreen()),
                  ),

                  Padding(
                    padding:
                    const EdgeInsets.only(top: 0, right: 0, bottom: 0, left: 0),
                    child: Card(

                      child: Container(
                          height:605,
                          width: 360,

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // Điều chỉnh vị trí bóng
                              ),
                            ],
                          ),
                          child: CartScreen()),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
