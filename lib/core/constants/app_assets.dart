/// App Assets Paths
/// Centralized asset path management
library;

class AppAssets {
  AppAssets._();

  // Base paths
  static const String _images = 'assets/images';
  static const String _icons = 'assets/icons';
  static const String _data = 'assets/data';
  static const String _audio = 'assets/audio';

  // Images
  static const String splashBackground = '$_images/splash_background.png';
  static const String islamicPattern = '$_images/islamic_pattern.png';
  static const String mosqueSilhouette = '$_images/mosque_silhouette.svg';
  static const String kaaba = '$_images/kaaba.svg';
  static const String quranOrnament = '$_images/quran_ornament.svg';
  static const String tasbeehBeads = '$_images/tasbeeh_beads.png';
  static const String compassBg = '$_images/compass_bg.png';
  static const String appIcon = '$_images/app_icon.png';

  // Lottie Animations
  static const String splashAnimation = '$_images/splash_animation.json';
  static const String loadingAnimation = '$_images/loading.json';
  static const String successAnimation = '$_images/success.json';

  // Data files
  static const String azkarData = '$_data/azkar.json';
  static const String quranData = '$_data/quran.json';
  static const String duasData = '$_data/duas.json';
  static const String allahNamesData = '$_data/allah_names.json';

  // Audio
  static const String adhanMakkah = '$_audio/adhan_makkah.mp3';
  static const String adhanMadinah = '$_audio/adhan_madinah.mp3';
  static const String clickSound = '$_audio/click.mp3';
  static const String tasbeehSound = '$_audio/tasbeeh.mp3';
}
