import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/services/secure_storage_service.dart';
import '../../core/utils/validators.dart';
import '../../data/repositories/auth_repository.dart';

class LoginViewModel extends GetxController {
  LoginViewModel(this._authRepository, this._secureStorage);

  final AuthRepository _authRepository;
  final SecureStorageService _secureStorage;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final errorMessage = RxnString();

  String? validateEmail(String? value) => Validators.email(value);

  String? validatePassword(String? value) => Validators.password(value);

  void toggleObscure() => obscurePassword.toggle();

  Future<void> submit() async {
    Get.focusScope?.unfocus();
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    errorMessage.value = null;
    try {
      final session = await _authRepository.login(
        email: emailController.text,
        password: passwordController.text,
      );
      await _secureStorage.saveToken(session.token);
      Get.offAllNamed(Routes.home);
    } on AuthException catch (e) {
      errorMessage.value = e.message;
    } catch (_) {
      errorMessage.value = 'Terjadi kesalahan. Periksa koneksi lalu coba lagi.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
