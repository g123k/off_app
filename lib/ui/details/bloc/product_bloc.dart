import 'package:betclic_app/api/model/product_response.dart';
import 'package:betclic_app/api/openfoodfacts_api.dart';
import 'package:betclic_app/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
      ProductAPIEntity resp = await GetIt.instance<IAPIManager>().loadProduct(
        event.barcode,
      );

      emitter(SuccessProductState(resp.response!.toProduct()));
    } catch (e, trace) {
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
