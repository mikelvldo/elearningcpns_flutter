# BelajarCPNS — Simple E-Learning (Flutter)

Aplikasi e-learning untuk Student: login, daftar course, detail course, dan memutar video lesson (YouTube).
Stack: Flutter, GetX (MVVM), Firebase Authentication, Cloud Firestore.

## Requirement

- Flutter SDK dengan Dart `^3.11.5` (cek `flutter --version`)
- Android Studio atau VS Code, dengan Android SDK
- JDK 17
- Emulator atau HP Android (minSdk 23)
- Koneksi internet (Firebase dan video YouTube)

## Instalasi

- Ekstrak project, lalu buka terminal di folder root project
- Jalankan `flutter pub get`

## Konfigurasi

Project ini sudah terhubung ke Firebase lewat `android/app/google-services.json` (project `elearningcpns-d8b55`), jadi tidak perlu konfigurasi tambahan.

Jika memakai project Firebase sendiri:

- Daftarkan aplikasi Android dengan package `com.example.elearning_app`
- Taruh `google-services.json` di `android/app/`
- Aktifkan  Authentication → Sign-in method → Email/Password
- Buat  Firestore Database  dengan Database ID `(default)`
- Isi koleksi sesuai struktur berikut:
  - `courses/{courseId}` dengan subkoleksi `lessons/{lessonId}`
  - `categories/{id}`, `instructors/{id}`, dan `users/{uid}`
- Rules Firestore: izinkan baca hanya untuk pengguna login (`request.auth != null`)
- Jika build gagal dengan error "incompatible version of Kotlin", naikkan versi plugin Kotlin di `android/settings.gradle`

## Cara menjalankan

- Sambungkan perangkat atau jalankan emulator, cek dengan `flutter devices`
- Jalankan `flutter run`
- Build APK: `flutter build apk --release`, hasilnya di `build/app/outputs/flutter-apk/app-release.apk`
- Setelah menambah atau mengubah package native, hentikan aplikasi lalu jalankan ulang. Hot restart tidak cukup.

## Akun demo

- Email: `demo@belajarcpns.id`
- Kata sandi: `demo1234`
- Akun ini ada di Firebase Authentication project di atas. Jika memakai project Firebase sendiri, buat akun ini secara manual.

## Catatan

- Platform yang dikonfigurasi: Android (iOS belum)
- Video diputar lewat embed YouTube. Jika pemilik video melarang embed, tersedia tombol *Buka di YouTube*.