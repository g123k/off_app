import 'package:hive_ce_flutter/adapters.dart';
import 'package:synchronized/synchronized.dart';

abstract class IAppStorage {
  Future<void> init();

  Future<List<String>> loadHistory();

  Future<bool> addBarcodeToHistory(String barcode);
}

class HiveAppStorage extends IAppStorage {
  late final Box<List<String>> box;
  final Lock dbLock = Lock();

  @override
  Future<void> init() async {
    dbLock.synchronized(() async {
      await Hive.initFlutter();
      box = await Hive.openBox('history');
    });
  }

  @override
  Future<bool> addBarcodeToHistory(String barcode) async {
    return dbLock.synchronized(() async {
      final List<String> history = _loadHistoryInternal();
      history.remove(barcode);
      history.insert(0, barcode);
      await box.put('history', history);
      return true;
    });
  }

  @override
  Future<List<String>> loadHistory() async {
    return dbLock.synchronized(() {
      return _loadHistoryInternal();
    });
  }

  List<String> _loadHistoryInternal() {
    return box.get('history', defaultValue: []) ?? <String>[];
  }
}
