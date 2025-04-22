import 'package:flutter/material.dart';
import 'theme/page_theme_mixin.dart';
import 'services/quiz_service.dart';
import 'services/words_api_service.dart';

class QuizPage extends StatefulWidget {
  final String difficulty;

  const QuizPage({super.key, this.difficulty = 'easy'});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with PageThemeMixin {
  final WordsApiService _wordsService = WordsApiService();
  List<Map<String, dynamic>> questions = [];
  int currentQuestion = 0;
  int score = 0;
  bool _isLoading = true;
  bool _showExplanation = false;
  String? currentWord;
  Map<String, dynamic>? wordDetails;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() => _isLoading = true);
    try {
      final loadedQuestions = await _wordsService.generateQuizQuestions(
        widget.difficulty,
      );
      setState(() {
        questions = loadedQuestions;
        _isLoading = false;
      });

      // Show error if no questions are available
      if (questions.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Failed to load questions. Using backup questions.',
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error loading questions: $e')));
      }
    }
  }

  void checkAnswer(int selectedOption) {
    setState(() => _showExplanation = true);

    if (selectedOption == questions[currentQuestion]['correct']) {
      score++;
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _showExplanation = false;
        if (currentQuestion < questions.length - 1) {
          currentQuestion++;
        } else {
          _showResults();
        }
      });
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: Text(
              score > (questions.length / 2)
                  ? '🎉 Congratulations!'
                  : '🤔 Keep Learning!',
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your Score: $score/${questions.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: score / questions.length,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    score > (questions.length / 2)
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    currentQuestion = 0;
                    score = 0;
                  });
                },
                child: const Text('Try Again'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: buildThemedAppBar(
        context,
        'Vocabulary Quiz - ${widget.difficulty.toUpperCase()}',
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                decoration: getPageBackgroundDecoration(context),
                child:
                    questions.isEmpty
                        ? Center(
                          child: buildThemedCard(
                            context,
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.warning_rounded,
                                    size: 64,
                                    color:
                                        isDark
                                            ? Colors.orange[300]
                                            : Colors.orange,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No Questions Available',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge?.copyWith(
                                      color:
                                          isDark
                                              ? Colors.white
                                              : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Please try another difficulty level or check your internet connection.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:
                                          isDark
                                              ? Colors.grey[300]
                                              : Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButton.icon(
                                    onPressed: _loadQuestions,
                                    icon: const Icon(Icons.refresh),
                                    label: const Text('Try Again'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          isDark
                                              ? Colors.blue[700]
                                              : Colors.blue,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        : ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            // Progress indicator
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Question ${currentQuestion + 1}/${questions.length}',
                                    style: TextStyle(
                                      color:
                                          isDark
                                              ? Colors.white
                                              : Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          isDark
                                              ? Colors.grey[700]
                                              : Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Score: $score',
                                      style: TextStyle(
                                        color:
                                            isDark
                                                ? Colors.white
                                                : Colors.blue.shade700,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Question card
                            buildThemedCard(
                              context,
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      questions[currentQuestion]['question'],
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall?.copyWith(
                                        color:
                                            isDark
                                                ? Colors.white
                                                : Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 24),
                                    ...List.generate(
                                      4,
                                      (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          child: ElevatedButton(
                                            onPressed:
                                                _showExplanation
                                                    ? null
                                                    : () => checkAnswer(index),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: _getOptionColor(
                                                index,
                                              ),
                                              foregroundColor:
                                                  isDark
                                                      ? Colors.white
                                                      : Colors.blue,
                                              padding: const EdgeInsets.all(16),
                                              elevation: isDark ? 2 : 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Text(
                                              questions[currentQuestion]['options'][index],
                                              style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    isDark
                                                        ? Colors.white
                                                        : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_showExplanation &&
                                        questions[currentQuestion]['explanation'] !=
                                            null)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: Text(
                                          questions[currentQuestion]['explanation'],
                                          style: TextStyle(
                                            color:
                                                isDark
                                                    ? Colors.blue[200]
                                                    : Colors.blue[700],
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
    );
  }

  Color _getOptionColor(int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (!_showExplanation) {
      return isDark ? Colors.grey[700]! : Colors.white;
    }
    if (index == questions[currentQuestion]['correct']) {
      return Colors.green.withOpacity(0.7);
    }
    return Colors.red.withOpacity(0.3);
  }
}
