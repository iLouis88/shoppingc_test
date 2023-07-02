import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/provider/cart_provider.dart';
import 'package:shopping_cart/provider/product_provider.dart';
import 'package:shopping_cart/screens/home_screen.dart';
import 'package:shopping_cart/screens/product_screen.dart';
import 'package:shopping_cart/widgets/cart_card.dart';
import 'package:shopping_cart/widgets/product_card.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'models/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()..loadCart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Cart',
        theme: ThemeData(
          textTheme: GoogleFonts.rubikTextTheme(
            Theme.of(context)
                .textTheme, // Sử dụng text theme hiện tại của hệ thống
          ),
        ),
        home:

        const HomeScreen(),

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

/*  @override
  void initState() {
    super.initState();
    ProductProvider productData = Provider.of<ProductProvider>(context, listen: false);
    productData.addProducts();
  }*/

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('TEST MY HOME PAGE'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                Product product =
                    Provider.of<ProductProvider>(context).products[index];
                return ProductCard(product: product);
              },
              childCount: Provider.of<ProductProvider>(context).products.length,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                Product product =
                    Provider.of<CartProvider>(context).products[index];
                return CartCard(product: product);
              },
              childCount: Provider.of<CartProvider>(context).products.length,
            ),
          ),
        ],
      ),
    );
  }
}
