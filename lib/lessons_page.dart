import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'services/flashcard_api_service.dart';
import 'theme/page_theme_mixin.dart';

class FlashCardPage extends StatefulWidget {
  final String language;
  final String category;

  const FlashCardPage({
    super.key,
    required this.language,
    required this.category,
  });

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage>
    with SingleTickerProviderStateMixin, PageThemeMixin {
  final FlashcardApiService _apiService = FlashcardApiService();
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Map<String, dynamic>> _flashcards = [];
  int _currentIndex = 0;
  bool _isFlipped = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _loadFlashcards();
  }

  Future<void> _loadFlashcards() async {
    try {
      final cards = await _apiService.getFlashcards(
        widget.language,
        widget.category,
      );
      setState(() {
        _flashcards = cards;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading flashcards: $e')));
    }
  }

  void _flipCard() {
    setState(() {
      if (_isFlipped) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isFlipped = !_isFlipped;
    });
  }

  void _nextCard() {
    setState(() {
      if (_currentIndex < _flashcards.length - 1) {
        _currentIndex++;
        if (_isFlipped) {
          _flipCard();
        }
      }
    });
  }

  void _previousCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        if (_isFlipped) {
          _flipCard();
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: getTheme(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.category.toUpperCase()} Flashcards'),
          backgroundColor: isDark ? Colors.grey[850] : Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.category),
              onPressed: () => _showCategoryPicker(context),
            ),
          ],
        ),
        body: Container(
          decoration: getPageDecoration(context),
          child:
              _isLoading
                  ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    ),
                  )
                  : _flashcards.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_dissatisfied,
                          size: 64,
                          color: Colors.purple.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        const Text('No flashcards available'),
                      ],
                    ),
                  )
                  : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Tap to flip, swipe to navigate',
                          style: TextStyle(
                            color: Colors.purple.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: _flipCard,
                          onHorizontalDragEnd: (details) {
                            if (details.primaryVelocity! > 0) {
                              _previousCard();
                            } else if (details.primaryVelocity! < 0) {
                              _nextCard();
                            }
                          },
                          child: TweenAnimationBuilder(
                            tween: Tween<double>(
                              begin: 0,
                              end: _isFlipped ? 180 : 0,
                            ),
                            duration: const Duration(milliseconds: 300),
                            builder: (context, double value, child) {
                              return Transform(
                                transform:
                                    Matrix4.identity()
                                      ..setEntry(3, 2, 0.001)
                                      ..rotateY((value * math.pi) / 180),
                                alignment: Alignment.center,
                                child:
                                    value >= 90
                                        ? Transform(
                                          transform:
                                              Matrix4.identity()
                                                ..rotateY(math.pi),
                                          alignment: Alignment.center,
                                          child: _buildCard(true),
                                        )
                                        : _buildCard(false),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildNavButton(
                              Icons.arrow_back_rounded,
                              _currentIndex > 0,
                              _previousCard,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${_currentIndex + 1}/${_flashcards.length}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            _buildNavButton(
                              Icons.arrow_forward_rounded,
                              _currentIndex < _flashcards.length - 1,
                              _nextCard,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  Widget _buildCard(bool isBack) {
    final frontGradient = [Colors.blue.shade400, Colors.lightBlue.shade800];
    final backGradient = [Colors.purple.shade400, Colors.deepPurple.shade800];
    final frontShadowColor = Colors.blue.shade200;
    final backShadowColor = Colors.purple.shade200;

    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 400, // Fixed height for better appearance
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: isBack ? backGradient : frontGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: isBack ? backShadowColor : frontShadowColor,
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isBack
                    ? _flashcards[_currentIndex]['back']
                    : _flashcards[_currentIndex]['front'],
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                _flashcards[_currentIndex]['pronunciation'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _flashcards[_currentIndex]['example'],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, bool enabled, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.deepPurple.shade400 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(30),
        boxShadow:
            enabled
                ? [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
                : null,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: enabled ? onPressed : null,
        color: Colors.white,
      ),
    );
  }

  void _showCategoryPicker(BuildContext context) {
    final categories = [
      'basics',
      'greetings',
      'time',
      'places',
      'food',
      'animals',
      'family',
      'objects',
    ];

    showModalBottomSheet(
      context: context,
      builder:
          (context) => ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                title: Text(category.toUpperCase()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => FlashCardPage(
                            language: widget.language,
                            category: category,
                          ),
                    ),
                  );
                },
              );
            },
          ),
    );
  }
}
