import 'package:betclic_app/storage/app_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

abstract class HomepageEvent {}

class LoadHistoryEvent extends HomepageEvent {}

class AddProductToHistoryEvent extends HomepageEvent {
  final String barcode;

  AddProductToHistoryEvent(this.barcode) : assert(barcode.isNotEmpty);
}

class HomepageBloc extends Bloc<HomepageEvent, List<String>> {
  final IAppStorage _storage;

  HomepageBloc() : _storage = GetIt.instance<IAppStorage>(), super(<String>[]) {
    on<AddProductToHistoryEvent>(_addProduct);
    on<LoadHistoryEvent>(_loadHistory);

    add(LoadHistoryEvent());
  }

  Future<void> _addProduct(
    AddProductToHistoryEvent event,
    Emitter<List<String>> emitter,
  ) async {
    // TODO
  }

  Future<void> _loadHistory(
    LoadHistoryEvent event,
    Emitter<List<String>> emitter,
  ) async {
    // TODO
  }
}
