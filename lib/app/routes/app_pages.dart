import 'package:get/get.dart';

import '../../modules/course_detail/course_detail_binding.dart';
import '../../modules/course_detail/course_detail_view.dart';
import '../../modules/home/home_binding.dart';
import '../../modules/home/home_view.dart';
import '../../modules/intro/intro_binding.dart';
import '../../modules/intro/intro_view.dart';
import '../../modules/login/login_binding.dart';
import '../../modules/player/player_binding.dart';
import '../../modules/player/player_view.dart';
import '../../modules/login/login_view.dart';
import '../../modules/splash/splash_binding.dart';
import '../../modules/splash/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.intro,
      page: () => const IntroView(),
      binding: IntroBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.courseDetail,
      page: () => const CourseDetailView(),
      binding: CourseDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.player,
      page: () => const PlayerView(),
      binding: PlayerBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
