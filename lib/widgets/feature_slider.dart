import 'package:flutter/material.dart';
import 'dart:async';
import '../word_grid_game.dart';
import '../translator_page.dart';
import '../lessons_page.dart';
import '../writing_practice_page.dart'; // Add this import
import '../models/language.dart'; // Add this import

class FeatureSlider extends StatefulWidget {
  const FeatureSlider({super.key});

  @override
  State<FeatureSlider> createState() => _FeatureSliderState();
}

class _FeatureSliderState extends State<FeatureSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'Learn Multiple Languages',
      'description': 'Master Gujarati, Hindi and English at your own pace',
      'icon': Icons.language,
    },
    {
      'title': 'Interactive Flashcards',
      'description': 'Practice with engaging flashcard exercises',
      'icon': Icons.flip,
    },
    {
      'title': 'Writing Practice',
      'description': 'Perfect your writing skills with guided exercises',
      'icon': Icons.edit,
    },
    {
      'title': 'Progress Tracking',
      'description': 'Monitor your learning journey',
      'icon': Icons.trending_up,
    },
    {
      'title': 'Quick Translation',
      'description': 'Instant translations at your fingertips',
      'icon': Icons.translate,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _navigateToFeature(BuildContext context, int index) {
    switch (index) {
      case 0: // Learn Multiple Languages
        // This will remain non-navigable as it's just informational
        break;
      case 1: // Interactive Flashcards
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Select Category'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        [
                              'basics',
                              'greetings',
                              'time',
                              'places',
                              'food',
                              'animals',
                              'family',
                              'objects',
                            ]
                            .map(
                              (category) => ListTile(
                                title: Text(category.toUpperCase()),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => FlashCardPage(
                                            language: 'hindi',
                                            category: category,
                                          ),
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
        );
        break;
      case 2: // Writing Practice
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => WritingPracticePage(
                  item: ContentItem(
                    character: 'अ',
                    pronunciation: 'a',
                    example: 'अनार (Pomegranate)',
                  ),
                  languageName: 'Multi-Language',
                ),
          ),
        );
        break;
      case 3: // Progress Tracking
        Navigator.pushNamed(context, '/profile');
        break;
      case 4: // Quick Translation
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TranslatorPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(bottom: 24),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _slides.length,
            itemBuilder: (context, index) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors:
                        isDark
                            ? [Colors.grey[800]!, Colors.grey[900]!]
                            : [
                              Colors.blue.shade400,
                              const Color.fromARGB(255, 0, 80, 130),
                            ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color:
                          isDark
                              ? Colors.black.withOpacity(0.3)
                              : Colors.blue.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border:
                      isDark
                          ? Border.all(color: Colors.grey[700]!, width: 1)
                          : null,
                ),
                child: InkWell(
                  onTap: () => _navigateToFeature(context, index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _slides[index]['icon'],
                        size: 48,
                        color: isDark ? Colors.blue[200] : Colors.white,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _slides[index]['title'],
                        style: TextStyle(
                          color: isDark ? Colors.blue[200] : Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          _slides[index]['description'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                isDark
                                    ? Colors.grey[300]
                                    : Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
