/// 1423 -> "23 mnt", 5400 -> "1j 30m"
String formatDuration(int seconds) {
  final hours = seconds ~/ 3600;
  final minutes = (seconds % 3600) ~/ 60;
  if (hours > 0) return minutes == 0 ? '${hours}j' : '${hours}j ${minutes}m';
  return '${minutes < 1 ? 1 : minutes} mnt';
}

String levelLabel(String level) {
  switch (level) {
    case 'beginner':
      return 'Pemula';
    case 'intermediate':
      return 'Menengah';
    case 'advanced':
      return 'Lanjutan';
    default:
      return level;
  }
}
