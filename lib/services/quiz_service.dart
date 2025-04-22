import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService {
  static const String _baseUrl =
      'https://64fc3bcf605a026163ae51d6.mockapi.io/api/v1';

  Future<List<Map<String, dynamic>>> getQuizQuestions(String language) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/quiz?language=$language'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => item as Map<String, dynamic>).toList();
      }
      return _getFallbackQuestions(language);
    } catch (e) {
      return _getFallbackQuestions(language);
    }
  }

  List<Map<String, dynamic>> _getFallbackQuestions(String language) {
    // Fallback questions if API fails
    final questions = {
      'hindi': [
        {
          'question': 'What is "Hello" in Hindi?',
          'options': ['Namaste', 'Alvida', 'Dhanyavaad', 'Shubh Raatri'],
          'correct': 0,
          'explanation': 'Namaste is the traditional greeting in Hindi',
        },
        // Add more questions
      ],
      'gujarati': [
        {
          'question': 'What is "Thank you" in Gujarati?',
          'options': ['Namaste', 'Aavjo', 'Aabhaar', 'Kem Cho'],
          'correct': 2,
          'explanation': 'Aabhaar means thank you in Gujarati',
        },
        // Add more questions
      ],
    };

    return questions[language] ?? [];
  }
}
