import 'package:betclic_app/storage/app_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'homepage_riverpod.g.dart';

@riverpod
class HomePageProvider extends _$HomePageProvider {
  final IAppStorage _storage;

  HomePageProvider() : _storage = GetIt.instance<IAppStorage>();

  @override
  FutureOr<List<String>> build() => _storage.loadHistory();

  Future<void> addBarcodeToHistory(String barcode) async {
    _storage.addBarcodeToHistory(barcode);
    state = await AsyncValue.guard(() {
      return _storage.loadHistory();
    });
  }
}
