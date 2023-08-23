import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:keychain_frontend/constants/storage.enum.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  LocalStorage._internal();

  final storage = const FlutterSecureStorage();

  void store(StorageEnum key, String value) async {
    await storage.write(key: key.toString(), value: value);
  }

  Future<String?> restore(StorageEnum key) async {
    return await storage.read(key: key.toString());
  }

  void remove(StorageEnum key) async {
    await storage.delete(key: key.toString());
  }

  void deleteAll() {
    storage.deleteAll();
  }
}
