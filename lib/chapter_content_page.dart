import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
import '../models/language.dart';
import 'practice_page.dart';
import 'writing_practice_page.dart';
import 'theme/page_theme_mixin.dart';

// Add DrawingPainter class at the top level
class DrawingPainter extends CustomPainter {
  final List<Offset?> points;

  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.blue.shade600
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 4.0; // Increased stroke width

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

class _ChapterContentPageState extends State<ChapterContentPage>
    with PageThemeMixin {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.languageName} - ${widget.chapter.title}'),
        backgroundColor: isDark ? Colors.grey[850] : Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                isDark
                    ? [Colors.grey[900]!, Colors.grey[850]!]
                    : [Colors.blue.shade50, Colors.lightBlue.shade50],
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
                  color: isDark ? Colors.white : Colors.blue,
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
                    elevation: isDark ? 2 : 4,
                    color: isDark ? Colors.grey[800] : Colors.white,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Text(
                                item.character,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall?.copyWith(
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '(${item.pronunciation})',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  color:
                                      isDark
                                          ? Colors.grey[300]
                                          : Colors.grey[700],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.volume_up,
                                  color:
                                      isDark ? Colors.blue[300] : Colors.blue,
                                ),
                                onPressed: () => _speakPronunciation(item),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color:
                                      isDark ? Colors.blue[300] : Colors.blue,
                                ),
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
                                      Text(
                                        'Example: ${item.example}',
                                        style: TextStyle(
                                          color:
                                              isDark
                                                  ? Colors.grey[300]
                                                  : Colors.grey[700],
                                        ),
                                      ),
                                      if (widget.chapter.title == 'Basics')
                                        Text(
                                          'Usage Tips: Try writing this character multiple times',
                                          style: TextStyle(
                                            color:
                                                isDark
                                                    ? Colors.blue[300]
                                                    : Colors.blue[700],
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
    );
  }
}
