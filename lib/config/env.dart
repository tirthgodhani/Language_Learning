class EnvConfig {
  // Primary Translation API (LibreTranslate)
  static const String translateApiUrl =
      'https://translate.argosopentech.com/translate';

  // Fallback Translation API (MyMemory)
  static const String fallbackApiUrl =
      'https://api.mymemory.translated.net/get';

  // Headers for API requests
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Supported languages
  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'hi': 'Hindi',
    'gu': 'Gujarati',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
    'ja': 'Japanese',
    'ar': 'Arabic',
  };

  // API Rate limiting
  static const Duration requestThrottle = Duration(milliseconds: 500);
  static const int maxRequestsPerMinute = 60;
}
