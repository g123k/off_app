import 'package:betclic_app/model/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_state.freezed.dart';

/// Générer le code avec
/// dart pub run build_runner watch --delete-conflicting-outputs

@freezed
sealed class ProductStateFreezed with _$ProductStateFreezed {
  const factory ProductStateFreezed.loading() = Loading;
  const factory ProductStateFreezed.success({required Product product}) =
      Success;
  const factory ProductStateFreezed.error() = Error;
}
