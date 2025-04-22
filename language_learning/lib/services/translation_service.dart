import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  // Using public LibreTranslate instance - you can self-host or use other instances
  static const String _baseUrl =
      "https://translate.argosopentech.com/translate";

  Future<String> translate({
    required String text,
    required String targetLanguage,
    String sourceLanguage = 'auto',
  }) async {
    try {
      // First try LibreTranslate
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'q': text,
          'source': sourceLanguage == 'auto' ? 'auto' : sourceLanguage,
          'target': targetLanguage,
          'format': 'text',
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['translatedText'];
      } else {
        // Fallback to MyMemory Translation API if LibreTranslate fails
        return _fallbackTranslate(text, sourceLanguage, targetLanguage);
      }
    } catch (e) {
      return _fallbackTranslate(text, sourceLanguage, targetLanguage);
    }
  }

  Future<String> _fallbackTranslate(
    String text,
    String sourceLanguage,
    String targetLanguage,
  ) async {
    try {
      // MyMemory Translation API as fallback
      final response = await http.get(
        Uri.parse(
          'https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(text)}&langpair=${sourceLanguage == "auto" ? "en" : sourceLanguage}|$targetLanguage',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['responseData']['translatedText'];
      } else {
        throw Exception('Translation failed');
      }
    } catch (e) {
      throw Exception('Translation error: $e');
    }
  }

  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'hi': 'Hindi',
    'gu': 'Gujarati',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
    'ja': 'Japanese',
    'ko': 'Korean',
    'zh': 'Chinese',
    'ru': 'Russian',
    'ar': 'Arabic',
    'bn': 'Bengali',
  };
}
