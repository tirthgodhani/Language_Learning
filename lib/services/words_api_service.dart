import 'dart:convert';
import 'package:http/http.dart' as http;

class WordsApiService {
  static const String _baseUrl = 'https://wordsapiv1.p.rapidapi.com/words';
  static const String _apiKey =
      '2408306c6emsh7ec62b09af9e427p135f62jsn053668dd2186'; // Replace with your API key

  Future<Map<String, dynamic>> getWordDetails(String word) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$word'),
        headers: {
          'X-RapidAPI-Key': _apiKey,
          'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load word details');
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> generateQuizQuestions(
    String difficulty,
  ) async {
    final words = await _getWordsByDifficulty(difficulty);
    final questions = <Map<String, dynamic>>[];

    // First try API questions
    for (final word in words..shuffle()) {
      try {
        final details = await getWordDetails(word);
        if (details['results'] != null && details['results'].isNotEmpty) {
          final question = _createQuestion(details);
          questions.add(question);
        }
      } catch (e) {
        print('Error generating question for $word: $e');
      }
    }

    // Add fallback questions if needed
    if (questions.length < 10) {
      final fallbackQuestions = _getFallbackQuestions(difficulty);
      fallbackQuestions.shuffle();
      questions.addAll(fallbackQuestions.take(10 - questions.length));
    }

    questions.shuffle();
    return questions.take(10).toList();
  }

  List<Map<String, dynamic>> _getFallbackQuestions(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return [
          _createSimpleQuestion(
            'What is the meaning of "happy"?',
            ['Joyful', 'Sad', 'Angry', 'Tired'],
            0,
            'Happy means feeling or showing pleasure or contentment.',
          ),
          _createSimpleQuestion(
            'Find the synonym for "big"',
            ['Large', 'Small', 'Tiny', 'Short'],
            0,
            'Large means the same as big.',
          ),
          _createSimpleQuestion(
            'What is the opposite of "hot"?',
            ['Cold', 'Warm', 'Cool', 'Mild'],
            0,
            'Cold is the antonym of hot.',
          ),
          // Add more easy questions...
        ];

      case 'medium':
        return [
          _createSimpleQuestion(
            'Define "resilient"',
            ['Adaptable', 'Rigid', 'Fragile', 'Weak'],
            0,
            'Resilient means able to recover quickly.',
          ),
          _createSimpleQuestion(
            'What does "profound" mean?',
            ['Deep', 'Shallow', 'Simple', 'Light'],
            0,
            'Profound means deep or intense.',
          ),
          // Add more medium questions...
        ];

      case 'hard':
        return [
          _createSimpleQuestion(
            'Define "ephemeral"',
            ['Short-lived', 'Permanent', 'Lasting', 'Eternal'],
            0,
            'Ephemeral means lasting for a very short time.',
          ),
          _createSimpleQuestion(
            'What does "ubiquitous" mean?',
            ['Present everywhere', 'Rare', 'Hidden', 'Unique'],
            0,
            'Ubiquitous means being present everywhere.',
          ),
          // Add more hard questions...
        ];

      default:
        return [];
    }
  }

  Map<String, dynamic> _createSimpleQuestion(
    String question,
    List<String> options,
    int correctIndex,
    String explanation,
  ) {
    return {
      'question': question,
      'options': options,
      'correct': correctIndex,
      'explanation': explanation,
      'type': 'definition',
    };
  }

  Map<String, dynamic> _createQuestion(Map<String, dynamic> wordDetails) {
    final results = wordDetails['results'][0];
    final word = wordDetails['word'];
    final definition = results['definition'];

    final questionTypes = [
      _createDefinitionQuestion,
      _createSynonymQuestion,
      _createAntonymQuestion,
    ];

    return questionTypes[_getRandomIndex(questionTypes.length)](wordDetails);
  }

  Map<String, dynamic> _createDefinitionQuestion(Map<String, dynamic> details) {
    final word = details['word'];
    final definition = details['results'][0]['definition'];
    final incorrectDefinitions = _getRandomDefinitions(details, 3);

    return {
      'question': 'What is the meaning of "$word"?',
      'options': [...incorrectDefinitions, definition]..shuffle(),
      'correct': [...incorrectDefinitions, definition].indexOf(definition),
      'type': 'definition',
      'word': word,
    };
  }

  Map<String, dynamic> _createSynonymQuestion(Map<String, dynamic> details) {
    final word = details['word'];
    final synonyms =
        details['results']
            .expand((result) => result['synonyms'] ?? [])
            .toSet()
            .toList();

    if (synonyms.isEmpty) {
      return _createDefinitionQuestion(details); // Fallback to definition
    }

    final correctSynonym = synonyms[_getRandomIndex(synonyms.length)];
    final otherWords = _getRandomWords(3); // Get 3 random incorrect options

    return {
      'question': 'Which word means the same as "$word"?',
      'options': [...otherWords, correctSynonym]..shuffle(),
      'correct': [...otherWords, correctSynonym].indexOf(correctSynonym),
      'type': 'synonym',
      'word': word,
    };
  }

  Map<String, dynamic> _createAntonymQuestion(Map<String, dynamic> details) {
    final word = details['word'];
    final antonyms =
        details['results']
            .expand((result) => result['antonyms'] ?? [])
            .toSet()
            .toList();

    if (antonyms.isEmpty) {
      return _createDefinitionQuestion(details); // Fallback to definition
    }

    final correctAntonym = antonyms[_getRandomIndex(antonyms.length)];
    final otherWords = _getRandomWords(3); // Get 3 random incorrect options

    return {
      'question': 'Which word means the opposite of "$word"?',
      'options': [...otherWords, correctAntonym]..shuffle(),
      'correct': [...otherWords, correctAntonym].indexOf(correctAntonym),
      'type': 'antonym',
      'word': word,
    };
  }

  List<String> _getRandomDefinitions(Map<String, dynamic> details, int count) {
    // Use some common definitions as fallback
    final fallbackDefinitions = [
      'A state or condition',
      'An action or process',
      'A person, place, or thing',
      'A characteristic or quality',
      'A relationship between things',
    ];

    final allDefinitions =
        details['results']
            .map((result) => result['definition'] as String)
            .where((def) => def != details['results'][0]['definition'])
            .toList();

    if (allDefinitions.length < count) {
      allDefinitions.addAll(fallbackDefinitions);
    }

    allDefinitions.shuffle();
    return allDefinitions.take(count).toList();
  }

  List<String> _getRandomWords(int count) {
    // Fallback random words
    final commonWords = [
      'happy',
      'sad',
      'big',
      'small',
      'fast',
      'slow',
      'good',
      'bad',
      'hot',
      'cold',
      'new',
      'old',
      'high',
      'low',
      'rich',
      'poor',
      'strong',
      'weak',
    ]..shuffle();

    return commonWords.take(count).toList();
  }

  // Helper methods implementation...
  List<String> _getWordsByDifficulty(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return [
          'happy',
          'good',
          'nice',
          'beautiful',
          'wise',
          'brave',
          'calm',
          'kind',
          'smart',
          'strong',
        ];
      case 'medium':
        return [
          'ambiguous',
          'profound',
          'resilient',
          'cognition',
          'paradigm',
          'authentic',
          'dynamic',
          'innovative',
          'pragmatic',
          'versatile',
        ];
      case 'hard':
        return [
          'ephemeral',
          'ubiquitous',
          'perspicacious',
          'ineffable',
          'serendipity',
          'esoteric',
          'fastidious',
          'mellifluous',
          'perfidious',
          'surreptitious',
        ];
      default:
        return ['happy', 'good', 'nice', 'beautiful', 'wise'];
    }
  }

  int _getRandomIndex(int max) => (DateTime.now().millisecondsSinceEpoch % max);
}
