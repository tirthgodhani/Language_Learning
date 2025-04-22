import 'package:flutter/material.dart';
import '../models/language.dart';
import '../chapter_content_page.dart';
import '../services/progress_service.dart';
import '../theme/page_theme_mixin.dart';

class HindiScreen extends StatefulWidget {
  const HindiScreen({super.key});

  @override
  State<HindiScreen> createState() => _HindiScreenState();
}

class _HindiScreenState extends State<HindiScreen> with PageThemeMixin {
  final language = Language(
    name: 'Hindi',
    imageUrl: Icons.translate,
    chapters: [
      Chapter(
        title: 'स्वर (Vowels)',
        description: 'Learn Hindi vowels',
        content: ChapterContent(
          title: 'हिंदी स्वर (Hindi Vowels)',
          items: [
            ContentItem(
              character: 'अ',
              pronunciation: 'a',
              example: 'अनार (Pomegranate)',
              usageTips: ['Start from top', 'Curve down and right'],
            ),
            ContentItem(
              character: 'आ',
              pronunciation: 'aa',
              example: 'आम (Mango)',
              usageTips: ['Like अ with vertical line'],
            ),
            ContentItem(
              character: 'इ',
              pronunciation: 'i',
              example: 'इमली (Tamarind)',
              usageTips: ['Dot and two curves'],
            ),
            // Add more vowels similar to Gujarati format...
          ],
        ),
      ),
      Chapter(
        title: 'व्यंजन (Consonants)',
        description: 'Learn Hindi consonants',
        content: ChapterContent(
          title: 'हिंदी व्यंजन (Hindi Consonants)',
          items: [
            ContentItem(
              character: 'क',
              pronunciation: 'ka',
              example: 'कमल (Lotus)',
              usageTips: ['Two parts', 'Horizontal line first'],
            ),
            ContentItem(
              character: 'ख',
              pronunciation: 'kha',
              example: 'खरगोश (Rabbit)',
              usageTips: ['क with circle on top'],
            ),
            // Add more consonants...
          ],
        ),
      ),
      Chapter(
        title: 'अंक (Numbers)',
        description: 'Learn numbers in Hindi',
        content: ChapterContent(
          title: 'हिंदी अंक (Hindi Numbers)',
          items: [
            ContentItem(
              character: '१',
              pronunciation: 'ek',
              example: 'One - पहला',
            ),
            ContentItem(
              character: '२',
              pronunciation: 'do',
              example: 'Two - दूसरा',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'अभिवादन (Greetings)',
        description: 'Common Hindi greetings',
        content: ChapterContent(
          title: 'हिंदी अभिवादन (Hindi Greetings)',
          items: [
            ContentItem(
              character: 'नमस्ते',
              pronunciation: 'namaste',
              example: 'Hello (Formal)',
            ),
            ContentItem(
              character: 'कैसे हैं आप?',
              pronunciation: 'kaise hain aap?',
              example: 'How are you?',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'खाना-पीना (Food & Drinks)',
        description: 'Learn food and drink related words',
        content: ChapterContent(
          title: 'खाना और पीना (Food & Drinks)',
          items: [
            ContentItem(
              character: 'पानी',
              pronunciation: 'paani',
              example: 'Water',
            ),
            ContentItem(
              character: 'चाय',
              pronunciation: 'chaay',
              example: 'Tea',
            ),
          ],
        ),
      ),
      // Add remaining chapters following Gujarati format:
      // - Greetings
      // - Common Phrases
      // - Food & Drinks
      // - Family Members
      // - Colors
      // - Days & Months
      // With detailed ContentItems for each
    ],
  );

  final _progressService = ProgressService();

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completedChapters = await _progressService.getProgress('hindi');
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

    final completedChapters =
        language.chapters
            .where((c) => c.isCompleted)
            .map((c) => c.title)
            .toList();
    await _progressService.saveProgress('hindi', completedChapters);
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
      appBar: buildThemedAppBar(context, 'हिंदी सीखें'),
      body: Container(
        decoration: getPageBackgroundDecoration(context),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color:
                        isDark ? Colors.black26 : Colors.blue.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
                border: isDark ? Border.all(color: Colors.grey[700]!) : null,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: isDark ? Colors.white : Colors.blue.shade700,
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
                              isDark ? Colors.grey[700] : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${(progress * 100).toInt()}%',
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress == 1.0 ? Colors.green : Colors.blue,
                    ),
                    minHeight: 10,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$completedChapters/${language.chapters.length} chapters completed',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: language.chapters.length,
                itemBuilder: (context, index) {
                  final chapter = language.chapters[index];
                  return buildThemedCard(
                    context,
                    ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        chapter.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        chapter.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
                            onPressed: () => _updateChapterStatus(chapter),
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
