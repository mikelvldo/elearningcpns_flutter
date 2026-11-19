import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/constants/firestore_paths.dart';
import '../models/auth_session.dart';
import 'auth_repository.dart';

/// Login via Firebase Authentication (email + kata sandi).
/// Nama tampilan diambil dari dokumen users/{uid}.
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user!;
      final token = await user.getIdToken() ?? user.uid;

      return AuthSession(
        token: token,
        name: await _readName(user),
        email: user.email ?? email.trim(),
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(_messageFor(e.code));
    }
  }

  @override
  Future<void> logout() => _auth.signOut();

  Future<String> _readName(User user) async {
    try {
      final doc =
          await _db.collection(FirestorePaths.users).doc(user.uid).get();
      final name = doc.data()?[FirestoreFields.name] as String?;
      if (name != null && name.isNotEmpty) return name;
    } catch (_) {
      // Profil gagal dibaca tidak boleh menggagalkan login.
    }
    return user.displayName ?? user.email ?? 'Peserta';
  }

  String _messageFor(String code) {
    switch (code) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
      case 'invalid-email':
        return 'Email atau kata sandi salah.';
      case 'user-disabled':
        return 'Akun ini dinonaktifkan.';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Coba lagi beberapa saat.';
      case 'network-request-failed':
        return 'Koneksi bermasalah. Periksa internet lalu coba lagi.';
      default:
        return 'Gagal masuk. Silakan coba lagi.';
    }
  }
}
