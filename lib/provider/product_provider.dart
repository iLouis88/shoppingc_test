import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future<void> addProducts() async {
    for (Product product in products) {
      Map<String, dynamic> productData = {
        'id': product.id,
        'image': product.image,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'color': '#${product.color.value.toRadixString(16)}'
      };
      await productsCollection.add(productData);
    }
    notifyListeners(); // thông báo cho các widget con
  }

  Future<List<Product>> getProducts() async {
    QuerySnapshot querySnapshot = await productsCollection.get();
    List<Product> products = [];
    querySnapshot.docs.forEach((doc) {
      products.add(Product(
        id: doc['id'],
        name: doc['name'],
        image: doc['image'],
        description: doc['description'],
        price: doc['price'],
        color: Color(int.parse(doc['color'].substring(1), radix: 16)),
      ));
    });
    return products;
  }

  List<Product> products = [
    Product(
      id: 1,
      name: 'Nike Air Zoom Pegasus 36',
      image:
          'https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-mens-running-shoe-wide-D24Mcz-removebg-preview.png',
      description:
          'The iconic Nike Air Zoom Pegasus 36 offers more cooling and mesh that targets breathability across high-heat areas. A slimmer heel collar and tongue reduce bulk, while exposed cables give you a snug fit at higher speeds.',
      price: 108.97,
      color: const Color(0xFFE1E7ED),
    ),
    Product(
      id: 2,
      name: 'Nike Air Zoom Pegasus 36 Shield',
      image:
          'https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/air-zoom-pegasus-36-shield-mens-running-shoe-24FBGb__1_-removebg-preview.png',
      description:
          'The Nike Air Zoom Pegasus 36 Shield gets updated to conquer wet routes. A water-repellent upper combines with an outsole that helps create grip on wet surfaces, letting you run in confidence despite the weather.',
      price: 89.97,
      color: const Color(0xFF4D317F),
    ),
    Product(
      id: 3,
      name: 'Nike CruzrOne',
      image:
          'https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/cruzrone-unisex-shoe-T2rRwS-removebg-preview.png',
      description:
          'Designed for steady, easy-paced movement, the Nike CruzrOne keeps you going. Its rocker-shaped sole and plush, lightweight cushioning let you move naturally and comfortably. The padded collar is lined with soft wool, adding luxury to every step, while mesh details let your foot breathe. There’s no finish line—there’s only you, one step after the next.',
      price: 100.97,
      color: const Color(0xFFE8D026),
    ),
    Product(
      id: 4,
      name: 'Nike Epic React Flyknit 2',
      image:
          'https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/epic-react-flyknit-2-mens-running-shoe-2S0Cn1-removebg-preview.png',
      description:
          'The Nike Epic React Flyknit 2 takes a step up from its predecessor with smooth, lightweight performance and a bold look. An updated Flyknit upper conforms to your foot with a minimal, supportive design. Underfoot, durable Nike React technology defies the odds by being both soft and responsive, for comfort that lasts as long as you can run.',
      price: 89.97,
      color: const Color(0xFFFD584A),
    ),
    Product(
      id: 5,
      name: 'Product 2',
      image:
          'https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/odyssey-react-flyknit-2-mens-running-shoe-T3VG7N-removebg-preview.png',
      description:
          'The Nike Odyssey React Flyknit 2 provides a strategic combination of lightweight Flyknit construction and synthetic material for support. Underfoot, Nike React cushioning delivers a soft, springy ride for a route that begs to be crushed.',
      price: 71.97,
      color: const Color(0xFFD4D7D6),
    ),
    Product(
        id: 6,
        image:
            "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/react-infinity-run-flyknit-mens-running-shoe-RQ484B__2_-removebg-preview.png",
        name: "Nike React Infinity Run Flyknit",
        description:
            "A pioneer in the running shoe frontier honors the original pioneer of running culture with the Nike React Infinity Run Flyknit. Blue Ribbon Track Club-inspired details pay homage to the haven that was created before running was even popular. This running shoe is designed to help reduce injury and keep you on the run. More foam and improved upper details provide a secure and cushioned feel.",
        price: 160.0,
        color: const Color(0xFFF2F5F4)),
    Product(
        id: 7,
        image:
            "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/react-miler-mens-running-shoe-DgF6nr-removebg-preview.png",
        name: "Nike React Miler",
        description:
            "The Nike React Miler gives you trusted stability for miles with athlete-informed performance. Made for dependability on your long runs, its intuitive design offers a locked-in fit and a durable feel.",
        price: 130.0,
        color: const Color(0xFF22AFDC)),
    Product(
        id: 8,
        image:
            "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/renew-ride-mens-running-shoe-JkhdfR-removebg-preview.png",
        name: "Nike Renew Ride",
        description:
            "The Nike Renew Ride helps keep the committed runner moving with plush cushioning. Firm support at the outsole helps you maintain stability no matter the distance.",
        price: 60.97,
        color: const Color(0xFFB50320)),
    Product(
        id: 9,
        image:
            "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/vaporfly-4-flyknit-running-shoe-v7G3FB-removebg-preview.png",
        name: "Nike Vaporfly 4% Flyknit",
        description:
            "Built to meet the exacting needs of world-class marathoners, Nike Vaporfly 4% Flyknit is designed for record-breaking speed. The Flyknit upper delivers breathable support, while the responsive foam and full-length plate provide incredible energy return for all 26.2.",
        price: 187.97,
        color: const Color(0xFF3569A1)),
    Product(
        id: 10,
        image:
            "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1315882/zoom-fly-3-premium-mens-running-shoe-XhzpPH-removebg-preview.png",
        name: "Nike Zoom Fly 3 Premium",
        description:
            "Inspired by the Vaporfly, the Nike Zoom Fly 3 Premium gives distance runners race-day comfort and durability. The power of a carbon fiber plate keeps you in the running mile after mile.",
        price: 160.0,
        color: const Color(0xFF54D4C9)),
  ];
}
