import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/error_banner.dart';
import '../../core/widgets/primary_button.dart';
import 'login_view_model.dart';
import 'widgets/demo_account_box.dart';

class LoginView extends GetView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48.h),
                const AppLogo(size: 64),
                SizedBox(height: 28.h),
                Text(
                  'Masuk ke ${AppStrings.appName}',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Masuk untuk melanjutkan belajar dan mengakses semua course.',
                  style: AppTextStyles.body.copyWith(fontSize: 14.sp),
                ),
                SizedBox(height: 32.h),
                AppTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  hint: 'nama@email.com',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  validator: controller.validateEmail,
                ),
                SizedBox(height: 16.h),
                _buildPasswordField(),
                _buildErrorBanner(),
                Obx(
                  () => PrimaryButton(
                    label: 'Masuk',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.submit,
                  ),
                ),
                SizedBox(height: 24.h),
                const DemoAccountBox(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () => AppTextField(
        controller: controller.passwordController,
        label: 'Kata sandi',
        hint: 'Masukkan kata sandi',
        icon: Icons.lock_outline_rounded,
        obscureText: controller.obscurePassword.value,
        textInputAction: TextInputAction.done,
        autofillHints: const [AutofillHints.password],
        validator: controller.validatePassword,
        onSubmitted: (_) => controller.submit(),
        suffix: IconButton(
          onPressed: controller.toggleObscure,
          icon: Icon(
            controller.obscurePassword.value
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorBanner() {
    return Obx(() {
      final message = controller.errorMessage.value;
      if (message == null) return SizedBox(height: 24.h);
      return Padding(
        padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
        child: ErrorBanner(message: message),
      );
    });
  }
}
