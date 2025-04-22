import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import '../models/language.dart';
import 'practice_page.dart';
import 'writing_practice_page.dart';

// Add DrawingPainter class at the top level
class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.blue
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 3.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class ChapterContentPage extends StatefulWidget {
  final Chapter chapter;
  final String languageName;

  const ChapterContentPage({
    super.key,
    required this.chapter,
    required this.languageName,
  });

  @override
  State<ChapterContentPage> createState() => _ChapterContentPageState();
}

class _ChapterContentPageState extends State<ChapterContentPage> {
  late FlutterTts flutterTts;
  bool _isTtsReady = false;
  List<Offset?> _points = []; // Add points list for drawing

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      // Check if TTS is available
      final engines = await flutterTts.getEngines;
      if (engines.isEmpty) {
        _showTtsError('No TTS engines found');
        return;
      }
      print('Available TTS engines: $engines');

      // Get available languages
      final languages = await flutterTts.getLanguages;
      print('Available languages: $languages');

      // Configure TTS
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.4);

      setState(() => _isTtsReady = true);
    } catch (e) {
      print('TTS initialization error: $e');
      _showTtsError('Failed to initialize TTS');
    }
  }

  Future<void> _openTtsSettings() async {
    try {
      // Try to open Android TTS settings
      const platform = MethodChannel('app.channel.shared.data');
      await platform.invokeMethod('openTTSSettings');
    } catch (e) {
      print('Failed to open TTS settings: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please open TTS settings manually and install required languages',
          ),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  void _showTtsError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Settings',
          textColor: Colors.white,
          onPressed: () {
            // Try to open device settings
            _openTtsSettings();
          },
        ),
      ),
    );
  }

  Future<void> _setLanguage(String language) async {
    try {
      String languageCode;
      switch (language) {
        case 'Hindi':
          // Try different Hindi language codes
          if (await flutterTts.isLanguageAvailable('hi-IN')) {
            languageCode = 'hi-IN';
          } else if (await flutterTts.isLanguageAvailable('hi')) {
            languageCode = 'hi';
          } else {
            languageCode = 'en-US'; // Fallback to English
          }
          break;
        case 'Gujarati':
          // Try different Gujarati language codes
          if (await flutterTts.isLanguageAvailable('gu-IN')) {
            languageCode = 'gu-IN';
          } else if (await flutterTts.isLanguageAvailable('gu')) {
            languageCode = 'gu';
          } else {
            languageCode = 'en-US'; // Fallback to English
          }
          break;
        default:
          languageCode = 'en-US';
      }

      await flutterTts.setLanguage(languageCode);
      print('Set language to: $languageCode');
    } catch (e) {
      print('Error setting language: $e');
    }
  }

  Future<void> _speakPronunciation(ContentItem item) async {
    if (!_isTtsReady) {
      _showTtsError('TTS is not ready. Please check TTS settings.');
      return;
    }

    try {
      // Get current engine
      final currentEngine = await flutterTts.getDefaultEngine;
      print('Using TTS engine: $currentEngine');

      // Set language and speak only the character
      await _setLanguage(widget.languageName);
      await flutterTts.speak(item.character);

      // Remove the delayed pronunciation speaking
      // await Future.delayed(const Duration(milliseconds: 1500));
      // if (widget.languageName != 'English') {
      //   await flutterTts.setLanguage('en-US');
      //   await flutterTts.speak(item.pronunciation);
      // }
    } catch (e) {
      print('Speech error: $e');
      _showTtsError('Failed to speak. Please check TTS settings.');
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    flutterTts.awaitSpeakCompletion(true);
    super.dispose();
  }

  void _startPractice(BuildContext context, ContentItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                PracticePage(item: item, languageName: widget.languageName),
      ),
    );
  }

  void _startQuickTest(BuildContext context) {
    // Create questions based on chapter content
    final questions =
        widget.chapter.content.items.map((item) {
            // Get 3 random wrong options from other items
            final otherItems =
                widget.chapter.content.items
                    .where((i) => i != item)
                    .map((i) => i.pronunciation)
                    .toList()
                  ..shuffle();

            return {
              'question': 'What is the pronunciation of "${item.character}"?',
              'character': item.character,
              'options': [item.pronunciation, ...otherItems.take(3)]..shuffle(),
              'correct': item.pronunciation,
            };
          }).toList()
          ..shuffle(); // Shuffle all questions

    int currentQuestionIndex = 0;
    int score = 0;
    bool hasAnswered = false;
    String? selectedAnswer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => StatefulBuilder(
            builder: (context, setState) {
              final currentQuestion = questions[currentQuestionIndex];

              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Column(
                  children: [
                    Text(
                      'Quick Test - ${widget.chapter.title}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: (currentQuestionIndex + 1) / questions.length,
                      backgroundColor: Colors.blue.shade100,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                    ),
                    Text(
                      'Question ${currentQuestionIndex + 1}/${questions.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            currentQuestion['character'] as String,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentQuestion['question'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...(currentQuestion['options'] as List<String>).map(
                      (option) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Material(
                          color: _getOptionColor(
                            option,
                            selectedAnswer,
                            currentQuestion['correct'] as String,
                            hasAnswered,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap:
                                hasAnswered
                                    ? null
                                    : () {
                                      setState(() {
                                        selectedAnswer = option;
                                        hasAnswered = true;
                                        if (option ==
                                            currentQuestion['correct']) {
                                          score++;
                                        }
                                      });

                                      Future.delayed(
                                        const Duration(seconds: 1),
                                        () {
                                          if (currentQuestionIndex <
                                              questions.length - 1) {
                                            setState(() {
                                              currentQuestionIndex++;
                                              hasAnswered = false;
                                              selectedAnswer = null;
                                            });
                                          } else {
                                            Navigator.pop(context);
                                            _showQuizResult(
                                              context,
                                              score,
                                              questions.length,
                                            );
                                          }
                                        },
                                      );
                                    },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Icon(
                                    _getOptionIcon(
                                      option,
                                      selectedAnswer,
                                      currentQuestion['correct'] as String,
                                      hasAnswered,
                                    ),
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      option,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Exit Quiz'),
                  ),
                ],
              );
            },
          ),
    );
  }

  Color _getOptionColor(
    String option,
    String? selectedAnswer,
    String correctAnswer,
    bool hasAnswered,
  ) {
    if (!hasAnswered) {
      return Colors.blue;
    }
    if (option == correctAnswer) {
      return Colors.green;
    }
    if (option == selectedAnswer) {
      return Colors.red;
    }
    return Colors.blue.withOpacity(0.6);
  }

  IconData _getOptionIcon(
    String option,
    String? selectedAnswer,
    String correctAnswer,
    bool hasAnswered,
  ) {
    if (!hasAnswered) {
      return Icons.radio_button_unchecked;
    }
    if (option == correctAnswer) {
      return Icons.check_circle;
    }
    if (option == selectedAnswer) {
      return Icons.cancel;
    }
    return Icons.radio_button_unchecked;
  }

  void _showQuizResult(BuildContext context, int score, int total) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Quiz Complete!',
              style: TextStyle(color: Colors.blue),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  score > total / 2 ? Icons.emoji_events : Icons.star,
                  size: 64,
                  color: score > total / 2 ? Colors.amber : Colors.blue,
                ),
                const SizedBox(height: 16),
                Text(
                  'Your Score',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
                Text(
                  '$score/$total',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _getResultMessage(score, total),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _startQuickTest(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Try Again'),
              ),
            ],
          ),
    );
  }

  String _getResultMessage(int score, int total) {
    final percentage = (score / total) * 100;
    if (percentage >= 90) {
      return 'Excellent! You\'re a master!';
    } else if (percentage >= 70) {
      return 'Great job! Keep it up!';
    } else if (percentage >= 50) {
      return 'Good effort! Practice more to improve!';
    } else {
      return 'Keep practicing! You\'ll get better!';
    }
  }

  Widget _buildPracticeSection(BuildContext context) {
    String title;
    switch (widget.languageName) {
      case 'Gujarati':
        title = 'ગુજરાતી લેખન અભ્યાસ (Writing Practice)';
        break;
      case 'Hindi':
        title = 'हिंदी लेखन अभ्यास (Writing Practice)';
        break;
      case 'English':
        title = 'English Writing Practice';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Practice writing ${widget.languageName} characters',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => WritingPracticePage(
                            item: widget.chapter.content.items[0],
                            languageName: widget.languageName,
                          ),
                    ),
                  ),
              icon: const Icon(Icons.edit),
              label: const Text('Practice Input'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.languageName} - ${widget.chapter.title}'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.lightBlue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.chapter.content.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount:
                    widget.chapter.content.items.length +
                    1, // +1 for practice section
                itemBuilder: (context, index) {
                  if (index == widget.chapter.content.items.length) {
                    return _buildPracticeSection(context);
                  }

                  final item = widget.chapter.content.items[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text(
                                item.character,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '(${item.pronunciation})',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              IconButton(
                                icon: const Icon(Icons.volume_up),
                                onPressed: () => _speakPronunciation(item),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _startPractice(context, item),
                              ),
                            ],
                          ),
                          subtitle:
                              item.example != null
                                  ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Example: ${item.example}'),
                                      if (widget.chapter.title == 'Basics')
                                        Text(
                                          'Usage Tips: Try writing this character multiple times',
                                          style: TextStyle(
                                            color: Colors.blue.shade700,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                    ],
                                  )
                                  : null,
                        ),
                        if (widget.chapter.title == 'Basics')
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Writing Order: Start from top-left, following the arrows',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _startQuickTest(context),
        label: const Text('Take Quick Test'),
        icon: const Icon(Icons.quiz),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
