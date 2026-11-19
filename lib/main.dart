import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/bindings/initial_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'core/constants/app_strings.dart';
import 'core/services/local_storage_service.dart';
import 'core/services/secure_storage_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hubungkan aplikasi ke Firebase (konfigurasi dibaca dari google-services.json).
  await Firebase.initializeApp();
  debugPrint('Firebase terhubung: ${Firebase.app().options.projectId}');



  // Service yang harus siap sebelum halaman pertama tampil.
  Get.put<SecureStorageService>(SecureStorageService(), permanent: true);
  await Get.putAsync<LocalStorageService>(
    () => LocalStorageService().init(),
    permanent: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Ukuran desain acuan (iPhone X / 375x812).
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          initialBinding: InitialBinding(),
          initialRoute: Routes.splash,
          getPages: AppPages.pages,
        );
      },
    );
  }
}