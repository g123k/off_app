import 'package:betclic_app/model/product.dart';
import 'package:flutter/cupertino.dart';

class ProductNotifier extends ValueNotifier<Product?> {
  ProductNotifier() : super(generateProduct());

  void changeProduct() {
    value = generateProduct();
  }
}
