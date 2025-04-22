import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env.dart';

class TranslationService {
  Future<String> translate({
    required String text,
    required String targetLanguage,
    String sourceLanguage = 'auto',
  }) async {
    try {
      // First try LibreTranslate
      final response = await http.post(
        Uri.parse(EnvConfig.translateApiUrl),
        headers: EnvConfig.defaultHeaders,
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
      final response = await http.get(
        Uri.parse(
          '${EnvConfig.fallbackApiUrl}?q=${Uri.encodeComponent(text)}&langpair=${sourceLanguage == "auto" ? "en" : sourceLanguage}|$targetLanguage',
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

  static Map<String, String> get supportedLanguages =>
      EnvConfig.supportedLanguages;
}
