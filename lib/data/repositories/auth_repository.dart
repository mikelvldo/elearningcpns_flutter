import '../models/auth_session.dart';

class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

abstract class AuthRepository {
  Future<AuthSession> login({required String email, required String password});

  /// Mengakhiri sesi di backend (token lokal dihapus oleh pemanggil).
  Future<void> logout();
}
