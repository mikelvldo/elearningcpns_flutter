import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../app/theme/app_colors.dart';
import '../../core/utils/format_utils.dart';
import '../../core/widgets/section_title.dart';
import 'player_view_model.dart';
import 'widgets/lesson_info_section.dart';
import 'widgets/player_error_overlay.dart';
import 'widgets/playlist_tile.dart';
import 'widgets/seek_overlay.dart';

class PlayerView extends GetView<PlayerViewModel> {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: controller.youtube,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.primary,
        progressColors: const ProgressBarColors(
          playedColor: AppColors.primary,
          handleColor: AppColors.primary,
          bufferedColor: Color(0x66FFFFFF),
          backgroundColor: Color(0x33FFFFFF),
        ),
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(),
        body: Column(
          children: [
            _buildVideoArea(player),
            Expanded(child: _buildLessonContent()),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
      title: Text(
        controller.course.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
          tooltip: 'Daftar course',
          onPressed: controller.goToCourseList,
          icon: const Icon(Icons.home_rounded),
        ),
      ],
    );
  }

  /// Video + lapisan double tap seek + lapisan error.
  Widget _buildVideoArea(Widget player) {
    return Stack(
      children: [
        player,
        Positioned.fill(child: SeekOverlay(controller: controller)),
        Positioned.fill(
          child: Obx(() {
            final message = controller.errorMessage.value;
            if (message == null) return const SizedBox.shrink();
            return PlayerErrorOverlay(
              message: message,
              onRetry: controller.retry,
              onOpenExternal: controller.canOpenExternally.value
                  ? controller.openInYoutube
                  : null,
            );
          }),
        ),
      ],
    );
  }

  Widget _buildLessonContent() {
    final lessons = controller.course.lessons;
    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      children: [
        LessonInfoSection(controller: controller),
        SizedBox(height: 28.h),
        const SectionTitle('Daftar lesson'),
        SizedBox(height: 12.h),
        for (var i = 0; i < lessons.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Obx(
              () => PlaylistTile(
                number: i + 1,
                title: lessons[i].title,
                duration: formatDuration(lessons[i].durationSeconds),
                isPlaying: controller.currentIndex.value == i,
                onTap: () => controller.selectLesson(i),
              ),
            ),
          ),
      ],
    );
  }
}
