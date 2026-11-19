import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../constants/storage_keys.dart';

/// Penyimpanan aman (Keystore / Keychain) khusus untuk token login.
class SecureStorageService extends GetxService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> saveToken(String token) =>
      _storage.write(key: StorageKeys.authToken, value: token);

  Future<String?> readToken() async {
    try {
      return await _storage.read(key: StorageKeys.authToken);
    } catch (_) {
      // Data keystore rusak/tidak terbaca: anggap belum login.
      await _storage.deleteAll();
      return null;
    }
  }

  Future<void> deleteToken() => _storage.delete(key: StorageKeys.authToken);
}
