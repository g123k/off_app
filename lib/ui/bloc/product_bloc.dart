import 'package:betclic_app/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProductEvent {}

class LoadProductEvent extends ProductEvent {
  final String barcode;

  LoadProductEvent(this.barcode) : assert(barcode.isNotEmpty);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(String barcode) : super(LoadingProductState()) {
    on<LoadProductEvent>(_loadProduct);
    add(LoadProductEvent(barcode));
  }

  Future<void> _loadProduct(
    LoadProductEvent event,
    Emitter<ProductState> emitter,
  ) async {
    emitter(LoadingProductState());

    try {
      await Future.delayed(Duration(seconds: 3));
      emitter(SuccessProductState(generateProduct()));
    } catch (e) {
      emitter(ErrorProductState(e));
    }
  }
}

sealed class ProductState {}

class LoadingProductState extends ProductState {}

class SuccessProductState extends ProductState {
  final Product product;

  SuccessProductState(this.product);
}

class ErrorProductState extends ProductState {
  final dynamic error;

  ErrorProductState(this.error);
}
