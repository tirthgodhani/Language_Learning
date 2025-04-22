import 'dart:convert';
import 'package:http/http.dart' as http;

class FlashcardApiService {
  // Using MockAPI.io as our backend
  static const String _baseUrl =
      'https://64fc3bcf605a026163ae51d6.mockapi.io/api/v1';

  Future<List<Map<String, dynamic>>> getFlashcards(
    String language,
    String category,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/flashcards?language=$language&category=$category'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => item as Map<String, dynamic>).toList();
      }
      return _getFallbackData(language, category);
    } catch (e) {
      return _getFallbackData(language, category);
    }
  }

  List<Map<String, dynamic>> _getFallbackData(
    String language,
    String category,
  ) {
    final fallbackData = {
      'hindi': {
        'basics': [
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
        ],
        'greetings': [
          {
            'front': 'शुभ प्रभात',
            'back': 'Good Morning',
            'pronunciation': 'Shubh Prabhat',
            'example': 'शुभ प्रभात, कैसी नींद आई?',
          },
          {
            'front': 'शुभ रात्रि',
            'back': 'Good Night',
            'pronunciation': 'Shubh Ratri',
            'example': 'शुभ रात्रि, अच्छे से सोना',
          },
        ],
        'time': [
          {
            'front': 'सुबह',
            'back': 'Morning',
            'pronunciation': 'Subah',
            'example': 'सुबह की सैर अच्छी होती है',
          },
          {
            'front': 'शाम',
            'back': 'Evening',
            'pronunciation': 'Shaam',
            'example': 'शाम को चाय पीएंगे',
          },
        ],
        'places': [
          {
            'front': 'मंदिर',
            'back': 'Temple',
            'pronunciation': 'Mandir',
            'example': 'मंदिर में शांति मिलती है',
          },
          {
            'front': 'घर',
            'back': 'House',
            'pronunciation': 'Ghar',
            'example': 'मेरा घर यहाँ है',
          },
        ],
        'food': [
          {
            'front': 'रोटी',
            'back': 'Bread',
            'pronunciation': 'Roti',
            'example': 'गरम रोटी खाओ',
          },
          {
            'front': 'दूध',
            'back': 'Milk',
            'pronunciation': 'Doodh',
            'example': 'दूध पीना सेहत के लिए अच्छा है',
          },
        ],
        'animals': [
          {
            'front': 'बिल्ली',
            'back': 'Cat',
            'pronunciation': 'Billi',
            'example': 'बिल्ली दूध पी रही है',
          },
          {
            'front': 'कुत्ता',
            'back': 'Dog',
            'pronunciation': 'Kutta',
            'example': 'कुत्ता भौंक रहा है',
          },
          {
            'front': 'गाय',
            'back': 'Cow',
            'pronunciation': 'Gaay',
            'example': 'गाय घास खा रही है',
          },
        ],
        'family': [
          {
            'front': 'माँ',
            'back': 'Mother',
            'pronunciation': 'Maa',
            'example': 'मेरी माँ खाना बना रही हैं',
          },
          {
            'front': 'पिता',
            'back': 'Father',
            'pronunciation': 'Pita',
            'example': 'मेरे पिता काम पर गए हैं',
          },
          {
            'front': 'बहन',
            'back': 'Sister',
            'pronunciation': 'Behen',
            'example': 'मेरी बहन स्कूल गई है',
          },
        ],
        'objects': [
          {
            'front': 'पानी',
            'back': 'Water',
            'pronunciation': 'Paani',
            'example': 'पानी पीजिये',
          },
          {
            'front': 'कपड़ा',
            'back': 'Cloth',
            'pronunciation': 'Kapda',
            'example': 'यह कपड़ा बहुत सुंदर है',
          },
        ],
      },
      'gujarati': {
        'basics': [
          {
            'front': 'નમસ્તે',
            'back': 'Hello',
            'pronunciation': 'Namaste',
            'example': 'નમસ્તે, કેમ છો?',
          },
          {
            'front': 'આભાર',
            'back': 'Thank you',
            'pronunciation': 'Aabhar',
            'example': 'તમારી મદદ માટે આભાર',
          },
        ],
        'greetings': [
          {
            'front': 'શુભ સવાર',
            'back': 'Good Morning',
            'pronunciation': 'Shubh Savar',
            'example': 'શુભ સવાર, કેમ ઊંઘ આવી?',
          },
          {
            'front': 'શુભ રાત્રી',
            'back': 'Good Night',
            'pronunciation': 'Shubh Ratri',
            'example': 'શુભ રાત્રી, સારી રીતે સૂવું',
          },
        ],
        'time': [
          {
            'front': 'સવાર',
            'back': 'Morning',
            'pronunciation': 'Savar',
            'example': 'સવારની કસરત સારી હોય છે',
          },
          {
            'front': 'સાંજ',
            'back': 'Evening',
            'pronunciation': 'Saanj',
            'example': 'સાંજે ચા પીશું',
          },
        ],
        'places': [
          {
            'front': 'મંદિર',
            'back': 'Temple',
            'pronunciation': 'Mandir',
            'example': 'મંદિરમાં શાંતિ મળે છે',
          },
          {
            'front': 'ઘર',
            'back': 'House',
            'pronunciation': 'Ghar',
            'example': 'મારું ઘર અહીં છે',
          },
        ],
        'food': [
          {
            'front': 'રોટલી',
            'back': 'Bread',
            'pronunciation': 'Rotli',
            'example': 'ગરમ રોટલી ખાવ',
          },
          {
            'front': 'દૂધ',
            'back': 'Milk',
            'pronunciation': 'Doodh',
            'example': 'દૂધ પીવું સ્વાસ્થ્ય માટે સારું છે',
          },
        ],
        'animals': [
          {
            'front': 'બિલાડી',
            'back': 'Cat',
            'pronunciation': 'Biladi',
            'example': 'બિલાડી દૂધ પી રહી છે',
          },
          {
            'front': 'કૂતરો',
            'back': 'Dog',
            'pronunciation': 'Kutro',
            'example': 'કૂતરો ભસી રહ્યો છે',
          },
          {
            'front': 'ગાય',
            'back': 'Cow',
            'pronunciation': 'Gaay',
            'example': 'ગાય ઘાસ ખાય છે',
          },
        ],
        'family': [
          {
            'front': 'માં',
            'back': 'Mother',
            'pronunciation': 'Maa',
            'example': 'મારી માં રસોઈ બનાવે છે',
          },
          {
            'front': 'પિતા',
            'back': 'Father',
            'pronunciation': 'Pita',
            'example': 'મારા પિતા કામ પર ગયા છે',
          },
          {
            'front': 'બહેન',
            'back': 'Sister',
            'pronunciation': 'Bahen',
            'example': 'મારી બહેન શાળા ગઈ છે',
          },
        ],
        'objects': [
          {
            'front': 'પાણી',
            'back': 'Water',
            'pronunciation': 'Paani',
            'example': 'પાણી પીઓ',
          },
          {
            'front': 'કપડું',
            'back': 'Cloth',
            'pronunciation': 'Kapdu',
            'example': 'આ કપડું ખૂબ સુંદર છે',
          },
        ],
      },
    };

    return fallbackData[language]?[category] ?? [];
  }

  Future<void> submitProgress(String userId, String language, int score) async {
    try {
      await http.post(
        Uri.parse('$_baseUrl/progress'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'language': language,
          'score': score,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );
    } catch (e) {
      print('Failed to submit progress: $e');
    }
  }
}
