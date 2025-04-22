import 'package:flutter/material.dart';
import '../models/language.dart';
import '../chapter_content_page.dart'; // Add this import
import '../services/progress_service.dart';
import 'dart:math';
import '../theme/page_theme_mixin.dart';

class GujaratiScreen extends StatefulWidget {
  const GujaratiScreen({super.key});

  @override
  State<GujaratiScreen> createState() => _GujaratiScreenState();
}

class _GujaratiScreenState extends State<GujaratiScreen>
    with SingleTickerProviderStateMixin, PageThemeMixin {
  final language = Language(
    name: 'Gujarati',
    imageUrl: Icons.language,
    chapters: [
      Chapter(
        title: 'Basics',
        description: 'Learn basic Gujarati alphabets',
        content: ChapterContent(
          title: 'ગુજરાતી મૂળાક્ષરો (Gujarati Alphabets)',
          items: [
            ContentItem(
              character: 'અ',
              pronunciation: 'a',
              example: 'અનાર (Pomegranate)',
              usageTips: [
                'Start from the top curve',
                'Practice the connecting line',
              ],
              writingOrder: 'Start from top, curve down and right',
            ),
            ContentItem(
              character: 'આ',
              pronunciation: 'aa',
              example: 'આંબો (Mango)',
            ),
            ContentItem(
              character: 'ઇ',
              pronunciation: 'i',
              example: 'ઇયળ (Caterpillar)',
            ),
            ContentItem(
              character: 'ઈ',
              pronunciation: 'ee',
              example: 'ઈંડું (Egg)',
            ),
            ContentItem(
              character: 'ઉ',
              pronunciation: 'u',
              example: 'ઉંદર (Mouse)',
            ),
            ContentItem(
              character: 'ઊ',
              pronunciation: 'oo',
              example: 'ઊન (Wool)',
            ),
            ContentItem(
              character: 'એ',
              pronunciation: 'e',
              example: 'એલચી (Cardamom)',
            ),
            ContentItem(
              character: 'ઐ',
              pronunciation: 'ai',
              example: 'ઐરાવત (Airavata)',
            ),
            ContentItem(
              character: 'ઓ',
              pronunciation: 'o',
              example: 'ઓછું (Less)',
            ),
            ContentItem(
              character: 'ઔ',
              pronunciation: 'au',
              example: 'ઔષધ (Medicine)',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Numbers',
        description: 'Learn numbers in Gujarati',
        content: ChapterContent(
          title: 'ગુજરાતી અંકો (Gujarati Numbers)',
          items: [
            ContentItem(
              character: '૧',
              pronunciation: 'Ek',
              example: 'One - પહેલું',
            ),
            ContentItem(
              character: '૨',
              pronunciation: 'Be',
              example: 'Two - બીજું',
            ),
            ContentItem(
              character: '૩',
              pronunciation: 'Tran',
              example: 'Three - ત્રીજું',
            ),
            ContentItem(
              character: '૪',
              pronunciation: 'Char',
              example: 'Four - ચોથું',
            ),
            ContentItem(
              character: '૫',
              pronunciation: 'Panch',
              example: 'Five - પાંચમું',
            ),
            ContentItem(
              character: '૬',
              pronunciation: 'Chha',
              example: 'Six - છઠ્ઠું',
            ),
            ContentItem(
              character: '૭',
              pronunciation: 'Saat',
              example: 'Seven - સાતમું',
            ),
            ContentItem(
              character: '૮',
              pronunciation: 'Aath',
              example: 'Eight - આઠમું',
            ),
            ContentItem(
              character: '૯',
              pronunciation: 'Nav',
              example: 'Nine - નવમું',
            ),
            ContentItem(
              character: '૧૦',
              pronunciation: 'Das',
              example: 'Ten - દસમું',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Greetings',
        description: 'Common greetings and phrases',
        content: ChapterContent(
          title: 'ગુજરાતી અભિવાદન (Gujarati Greetings)',
          items: [
            ContentItem(
              character: 'નમસ્તે',
              pronunciation: 'Namaste',
              example: 'Hello (Formal)',
            ),
            ContentItem(
              character: 'કેમ છો?',
              pronunciation: 'Kem Chho?',
              example: 'How are you?',
            ),
            ContentItem(
              character: 'સારું છું',
              pronunciation: 'Saru Chhu',
              example: 'I am fine',
            ),
            ContentItem(
              character: 'આવજો',
              pronunciation: 'Aavjo',
              example: 'Goodbye',
            ),
            ContentItem(
              character: 'શુભ સવાર',
              pronunciation: 'Shubh Savar',
              example: 'Good Morning',
            ),
            ContentItem(
              character: 'શુભ રાત્રી',
              pronunciation: 'Shubh Ratri',
              example: 'Good Night',
            ),
            ContentItem(
              character: 'આભાર',
              pronunciation: 'Aabhar',
              example: 'Thank you',
            ),
            ContentItem(
              character: 'માફ કરજો',
              pronunciation: 'Maaf Karjo',
              example: 'Sorry',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Common Phrases',
        description: 'Essential everyday phrases',
        content: ChapterContent(
          title: 'રોજિંદા વાક્યો (Daily Phrases)',
          items: [
            ContentItem(
              character: 'તમારું નામ શું છે?',
              pronunciation: 'Tamaru naam shu chhe?',
              example: 'What is your name?',
            ),
            ContentItem(
              character: 'મારું નામ ... છે',
              pronunciation: 'Maru naam ... chhe',
              example: 'My name is ...',
            ),
            ContentItem(
              character: 'મને સમજાતું નથી',
              pronunciation: 'Mane samjatu nathi',
              example: 'I don\'t understand',
            ),
            ContentItem(
              character: 'ધીમે બોલો',
              pronunciation: 'Dhime bolo',
              example: 'Please speak slowly',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Food & Drinks',
        description: 'Learn food and drink related words',
        content: ChapterContent(
          title: 'ખોરાક અને પીણાં (Food & Drinks)',
          items: [
            ContentItem(
              character: 'પાણી',
              pronunciation: 'Paani',
              example: 'Water',
            ),
            ContentItem(character: 'ચા', pronunciation: 'Chaa', example: 'Tea'),
            ContentItem(
              character: 'રોટલી',
              pronunciation: 'Rotli',
              example: 'Flatbread',
            ),
            ContentItem(
              character: 'શાક',
              pronunciation: 'Shaak',
              example: 'Vegetable curry',
            ),
            ContentItem(
              character: 'દાળ',
              pronunciation: 'Daal',
              example: 'Lentils',
            ),
            ContentItem(
              character: 'ભાત',
              pronunciation: 'Bhaat',
              example: 'Rice',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Family Members',
        description: 'Learn family relation terms',
        content: ChapterContent(
          title: 'કુટુંબના સભ્યો (Family Members)',
          items: [
            ContentItem(
              character: 'માતા',
              pronunciation: 'Mata',
              example: 'Mother',
            ),
            ContentItem(
              character: 'પિતા',
              pronunciation: 'Pita',
              example: 'Father',
            ),
            ContentItem(
              character: 'ભાઈ',
              pronunciation: 'Bhai',
              example: 'Brother',
            ),
            ContentItem(
              character: 'બહેન',
              pronunciation: 'Bahen',
              example: 'Sister',
            ),
            ContentItem(
              character: 'દાદા',
              pronunciation: 'Dada',
              example: 'Grandfather',
            ),
            ContentItem(
              character: 'દાદી',
              pronunciation: 'Dadi',
              example: 'Grandmother',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Colors',
        description: 'Learn color names',
        content: ChapterContent(
          title: 'રંગો (Colors)',
          items: [
            ContentItem(character: 'લાલ', pronunciation: 'Lal', example: 'Red'),
            ContentItem(
              character: 'પીળો',
              pronunciation: 'Pilo',
              example: 'Yellow',
            ),
            ContentItem(
              character: 'વાદળી',
              pronunciation: 'Vadli',
              example: 'Blue',
            ),
            ContentItem(
              character: 'લીલો',
              pronunciation: 'Lilo',
              example: 'Green',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Days & Months',
        description: 'Learn days and months',
        content: ChapterContent(
          title: 'વાર અને મહિના (Days & Months)',
          items: [
            // Days
            ContentItem(
              character: 'સોમવાર',
              pronunciation: 'Somvar',
              example: 'Monday',
            ),
            ContentItem(
              character: 'મંગળવાર',
              pronunciation: 'Mangalvar',
              example: 'Tuesday',
            ),
            ContentItem(
              character: 'બુધવાર',
              pronunciation: 'Budhvar',
              example: 'Wednesday',
            ),
            ContentItem(
              character: 'ગુરુવાર',
              pronunciation: 'Guruvar',
              example: 'Thursday',
            ),
            ContentItem(
              character: 'શુક્રવાર',
              pronunciation: 'Shukravar',
              example: 'Friday',
            ),
            ContentItem(
              character: 'શનિવાર',
              pronunciation: 'Shanivar',
              example: 'Saturday',
            ),
            ContentItem(
              character: 'રવિવાર',
              pronunciation: 'Ravivar',
              example: 'Sunday',
            ),
            // Months
            ContentItem(
              character: 'જાન્યુઆરી',
              pronunciation: 'January',
              example: 'First month',
            ),
            ContentItem(
              character: 'ફેબ્રુઆરી',
              pronunciation: 'February',
              example: 'Second month',
            ),
            ContentItem(
              character: 'માર્ચ',
              pronunciation: 'March',
              example: 'Third month',
            ),
            ContentItem(
              character: 'એપ્રિલ',
              pronunciation: 'April',
              example: 'Fourth month',
            ),
            ContentItem(
              character: 'મે',
              pronunciation: 'May',
              example: 'Fifth month',
            ),
            ContentItem(
              character: 'જૂન',
              pronunciation: 'June',
              example: 'Sixth month',
            ),
            ContentItem(
              character: 'જુલાઈ',
              pronunciation: 'July',
              example: 'Seventh month',
            ),
            ContentItem(
              character: 'ઓગસ્ટ',
              pronunciation: 'August',
              example: 'Eighth month',
            ),
            ContentItem(
              character: 'સપ્ટેમ્બર',
              pronunciation: 'September',
              example: 'Ninth month',
            ),
            ContentItem(
              character: 'ઓક્ટોબર',
              pronunciation: 'October',
              example: 'Tenth month',
            ),
            ContentItem(
              character: 'નવેમ્બર',
              pronunciation: 'November',
              example: 'Eleventh month',
            ),
            ContentItem(
              character: 'ડિસેમ્બર',
              pronunciation: 'December',
              example: 'Twelfth month',
            ),
          ],
        ),
      ),

      // Add remaining chapters: Greetings, Common Phrases, Food & Drinks, Family Members, Colors, Days & Months
    ],
  );

  final _progressService = ProgressService();

  late AnimationController _animationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
    );

    _loadProgress();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadProgress() async {
    final completedChapters = await _progressService.getProgress('gujarati');
    setState(() {
      for (var chapter in language.chapters) {
        chapter.isCompleted = completedChapters.contains(chapter.title);
      }
    });
  }

  void _updateChapterStatus(Chapter chapter) async {
    setState(() {
      chapter.isCompleted = !chapter.isCompleted;
    });

    // Save progress to Firebase
    final completedChapters =
        language.chapters
            .where((c) => c.isCompleted)
            .map((c) => c.title)
            .toList();
    await _progressService.saveProgress('gujarati', completedChapters);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final completedChapters =
        language.chapters.where((c) => c.isCompleted).length;
    final progress =
        language.chapters.isEmpty
            ? 0.0
            : completedChapters / language.chapters.length;

    return Scaffold(
      appBar: buildThemedAppBar(context, 'ગુજરાતી શીખો'),
      body: Container(
        decoration: getPageBackgroundDecoration(context),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _waveAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, 2 * sin(_waveAnimation.value * 3.14)),
                  child: buildThemedCard(
                    context,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Progress',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${(progress * 100).toInt()}%',
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          AnimatedBuilder(
                            animation: _progressAnimation,
                            builder: (context, child) {
                              return Column(
                                children: [
                                  LinearProgressIndicator(
                                    value: progress * _progressAnimation.value,
                                    backgroundColor: Colors.grey.shade200,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      progress == 1.0
                                          ? Colors.green
                                          : Colors.blue,
                                    ),
                                    minHeight: 10,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '$completedChapters/${language.chapters.length} chapters completed',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: language.chapters.length,
                itemBuilder: (context, index) {
                  final chapter = language.chapters[index];
                  return AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final delay = index * 0.2;
                      final slideAnimation = Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(
                            delay.clamp(0.0, 1.0),
                            (delay + 0.2).clamp(0.0, 1.0),
                            curve: Curves.easeOut,
                          ),
                        ),
                      );

                      return SlideTransition(
                        position: slideAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'chapter_${chapter.title}',
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(chapter.title),
                              subtitle: Text(chapter.description),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_forward),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ChapterContentPage(
                                                chapter: chapter,
                                                languageName: language.name,
                                              ),
                                        ),
                                      );
                                    },
                                  ),
                                  ElevatedButton.icon(
                                    onPressed:
                                        () => _updateChapterStatus(chapter),
                                    icon: Icon(
                                      chapter.isCompleted
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    label: Text(
                                      chapter.isCompleted ? 'Done' : 'Mark',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          chapter.isCompleted
                                              ? Colors.green
                                              : Colors.blue,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      minimumSize: const Size(60, 32),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
