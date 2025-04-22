import 'package:flutter/material.dart';
import '../models/language.dart';
import 'language_detail_page.dart';
import 'quiz_page.dart';
import 'translator_page.dart';
import 'lessons_page.dart'; // Add this import
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/gujarati_screen.dart';
import 'screens/hindi_screen.dart';
import 'screens/english_screen.dart';
import 'word_grid_game.dart'; // Add this import
import 'dart:async';
import 'widgets/feature_slider.dart';

class HomePage extends StatefulWidget {
  // Change to StatefulWidget
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to login screen and remove all previous routes
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  final List<Language> languages = [
    Language(
      name: 'Gujarati',
      imageUrl: Icons.language,
      chapters: [], // Add empty chapters list
    ),
    Language(
      name: 'Hindi',
      imageUrl: Icons.translate,
      chapters: [], // Add empty chapters list
    ),
    Language(
      name: 'English',
      imageUrl: Icons.abc,
      chapters: [], // Add empty chapters list
    ),
  ];

  static void navigateToLanguage(BuildContext context, Language language) {
    switch (language.name) {
      case 'Gujarati':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GujaratiScreen()),
        );
        break;
      case 'Hindi':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HindiScreen()),
        );
        break;
      case 'English':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EnglishScreen()),
        );
        break;
    }
  }

  void _showDifficultyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Difficulty'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.star_outline, color: Colors.green),
                  title: const Text('Easy'),
                  onTap: () => _startQuiz(context, 'easy'),
                ),
                ListTile(
                  leading: const Icon(Icons.star_half, color: Colors.orange),
                  title: const Text('Medium'),
                  onTap: () => _startQuiz(context, 'medium'),
                ),
                ListTile(
                  leading: const Icon(Icons.star, color: Colors.red),
                  title: const Text('Hard'),
                  onTap: () => _startQuiz(context, 'hard'),
                ),
              ],
            ),
          ),
    );
  }

  void _startQuiz(BuildContext context, String difficulty) {
    Navigator.pop(context); // Close dialog
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizPage(difficulty: difficulty)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Learning'),
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[850]
                : Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[700]
                      : Colors.blue[700],
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[600]!
                        : Colors.transparent,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => Navigator.pushNamed(context, '/profile'),
              tooltip: 'Profile',
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:
                Theme.of(context).brightness == Brightness.dark
                    ? [Colors.grey[900]!, Colors.grey[800]!]
                    : [Colors.blue.shade50, Colors.purple.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const FeatureSlider(), // Replace slider code with this widget
            Text(
              'Available Languages',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children:
                  languages
                      .map((lang) => LanguageCard(language: lang))
                      .toList(),
            ),
            const SizedBox(height: 32),
            Text(
              'Learning Tools',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                FeatureCard(
                  title: 'Quiz',
                  icon: Icons.quiz,
                  color: Colors.orange,
                  onTap: () => _showDifficultyDialog(context),
                ),
                FeatureCard(
                  title: 'Translator',
                  icon: Icons.translate,
                  color: Colors.green,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TranslatorPage(),
                        ),
                      ),
                ),
                FeatureCard(
                  title: 'Flash Cards',
                  icon: Icons.flip,
                  color: Colors.indigo,
                  onTap: () => _showCategoryDialog(context),
                ),
                FeatureCard(
                  title: 'Word Grid',
                  icon: Icons.grid_on,
                  color: Colors.indigo,
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WordGridGame(),
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog(BuildContext context) {
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

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Category'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    categories.map((category) {
                      return ListTile(
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
                      );
                    }).toList(),
              ),
            ),
          ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? Colors.grey[800] : Colors.white;
    final iconColor = isDark ? color.withOpacity(0.8) : color;

    return Card(
      elevation: isDark ? 2 : 4,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.grey[700]! : Colors.transparent,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDark ? Colors.white : color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageCard extends StatelessWidget {
  final Language language;
  final Map<String, Color> languageColors = {
    'Gujarati': Colors.blue,
    'Hindi': Colors.blue,
    'English': Colors.blue,
  };

  LanguageCard({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? Colors.grey[800] : Colors.white;

    return Card(
      elevation: isDark ? 2 : 4,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.grey[700]! : Colors.transparent,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => _HomePageState.navigateToLanguage(context, language),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              language.imageUrl as IconData, // Cast to IconData
              size: 48,
              color:
                  isDark
                      ? Colors.blue.shade200
                      : languageColors[language.name] ?? Colors.blue,
            ),
            const SizedBox(height: 8),
            Text(
              language.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color:
                    isDark
                        ? Colors.white
                        : languageColors[language.name] ?? Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: LinearProgressIndicator(
                value: language.progress,
                backgroundColor: isDark ? Colors.grey[700] : Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  isDark
                      ? Colors.blue.shade200
                      : languageColors[language.name] ?? Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
