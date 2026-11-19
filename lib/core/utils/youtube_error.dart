/// Memetakan kode error pemutar YouTube ke pesan yang mudah dipahami.
String youtubeErrorMessage(int code) {
  switch (code) {
    case 2:
      return 'Link video tidak valid.';
    case 5:
      return 'Terjadi kesalahan pada pemutar video.';
    case 100:
      return 'Video tidak ditemukan atau bersifat privat.';
    case 101:
    case 150:
      return 'Pemilik video tidak mengizinkan video ini diputar di dalam aplikasi.';
    default:
      return 'Video gagal diputar (kode $code).';
  }
}

/// Error 101/150: video hanya bisa dibuka lewat aplikasi YouTube.
bool isEmbedBlocked(int code) => code == 101 || code == 150;
