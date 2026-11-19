import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';

import 'local_storage_service.dart';

/// Mengambil thumbnail video YouTube, lalu menyimpannya (base64) di
/// SharedPreferences agar tampil instan dan tetap ada saat offline.
class ThumbnailService extends GetxService {
  ThumbnailService(this._local);

  final LocalStorageService _local;

  /// https://www.youtube.com/watch?v=ID  atau  https://youtu.be/ID
  static String? videoIdFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.first;
    }
    return uri.queryParameters['v'];
  }

  /// Baca dari cache saja (sinkron, tanpa jaringan).
  Uint8List? getCached(String? videoUrl) {
    if (videoUrl == null) return null;
    final id = videoIdFromUrl(videoUrl);
    if (id == null) return null;
    final raw = _local.getThumbnail(id);
    if (raw == null) return null;
    try {
      return base64Decode(raw);
    } catch (_) {
      return null;
    }
  }

  /// Cache dulu; kalau belum ada, unduh lalu simpan.
  Future<Uint8List?> getThumbnail(String? videoUrl) async {
    if (videoUrl == null) return null;
    final cached = getCached(videoUrl);
    if (cached != null) return cached;

    final id = videoIdFromUrl(videoUrl);
    if (id == null) return null;

    final bytes = await _download('https://img.youtube.com/vi/$id/hqdefault.jpg');
    if (bytes != null && bytes.isNotEmpty) {
      await _local.saveThumbnail(id, base64Encode(bytes));
    }
    return bytes;
  }

  Future<Uint8List?> _download(String url) async {
    final client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 8);
    try {
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close().timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return null;
      final builder = BytesBuilder();
      await for (final chunk in response) {
        builder.add(chunk);
      }
      return builder.takeBytes();
    } catch (_) {
      return null; // offline / timeout: UI memakai placeholder
    } finally {
      client.close(force: true);
    }
  }
}
