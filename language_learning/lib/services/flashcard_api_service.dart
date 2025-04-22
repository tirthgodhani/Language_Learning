import 'dart:convert';
import 'package:http/http.dart' as http;

class FlashcardApiService {
  Future<List<Map<String, dynamic>>> getFlashcards(
    String language,
    String category,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://yourapi.com/flashcards?lang=$language&cat=$category',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        // Return mock data for demonstration
        return [
          {
            'front': 'नमस्ते',
            'back': 'Hello',
            'pronunciation': 'Namaste',
            'example': 'नमस्ते, कैसे हो?',
          },
          {
            'front': 'धन्यवाद',
            'back': 'Thank you',
            'pronunciation': 'Dhanyavaad',
            'example': 'आपकी मदद के लिए धन्यवाद',
          },
        ];
      }
    } catch (e) {
      // Return mock data on error
      return [
        {
          'front': 'नमस्ते',
          'back': 'Hello',
          'pronunciation': 'Namaste',
          'example': 'नमस्ते, कैसे हो?',
        },
        {
          'front': 'धन्यवाद',
          'back': 'Thank you',
          'pronunciation': 'Dhanyavaad',
          'example': 'आपकी मदद के लिए धन्यवाद',
        },
      ];
    }
  }
}
