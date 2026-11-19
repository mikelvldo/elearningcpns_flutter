import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/last_learning.dart';
import '../constants/storage_keys.dart';

/// Penyimpanan internal biasa: status intro dan log terakhir belajar.
class LocalStorageService extends GetxService {
  late final SharedPreferences _prefs;

  Future<LocalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // ---- Intro ----
  bool get hasSeenIntro => _prefs.getBool(StorageKeys.hasSeenIntro) ?? false;

  Future<void> setIntroSeen() => _prefs.setBool(StorageKeys.hasSeenIntro, true);

  // ---- Log terakhir belajar ----
  LastLearning? get lastLearning {
    final raw = _prefs.getString(StorageKeys.lastLearning);
    if (raw == null) return null;
    try {
      return LastLearning.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLastLearning(LastLearning data) =>
      _prefs.setString(StorageKeys.lastLearning, jsonEncode(data.toJson()));

  Future<void> clearLastLearning() => _prefs.remove(StorageKeys.lastLearning);

  // ---- Cache thumbnail video (base64) ----
  String? getThumbnail(String videoId) =>
      _prefs.getString('${StorageKeys.thumbnailPrefix}$videoId');

  Future<void> saveThumbnail(String videoId, String base64Data) =>
      _prefs.setString('${StorageKeys.thumbnailPrefix}$videoId', base64Data);
}
