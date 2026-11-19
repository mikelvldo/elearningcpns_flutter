class StorageKeys {
  // Secure storage
  static const authToken = 'auth_token';

  // Penyimpanan internal biasa (SharedPreferences)
  static const hasSeenIntro = 'has_seen_intro';
  static const lastLearning = 'last_learning';

  /// Cache thumbnail video (base64). Key lengkap: thumb_<videoId>
  static const thumbnailPrefix = 'thumb_';
}
