import 'package:betclic_app/ui/details/product_tab0.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  static const double IMAGE_HEIGHT = 300.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProductTab0());
  }
}
