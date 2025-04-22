import 'package:flutter/material.dart';
import '../models/language.dart';
import '../chapter_content_page.dart'; // Add this import
import '../services/progress_service.dart';
import '../theme/page_theme_mixin.dart';

class EnglishScreen extends StatefulWidget {
  const EnglishScreen({super.key});

  @override
  State<EnglishScreen> createState() => _EnglishScreenState();
}

class _EnglishScreenState extends State<EnglishScreen> with PageThemeMixin {
  final language = Language(
    name: 'English',
    imageUrl: Icons.abc,
    chapters: [
      Chapter(
        title: 'Basics',
        description: 'Learn basic English alphabets',
        content: ChapterContent(
          title: 'English Alphabets',
          items: [
            ContentItem(
              character: 'A',
              pronunciation: 'ay',
              example: 'Apple',
              usageTips: ['Start from top point', 'Draw diagonal lines'],
            ),
            ContentItem(
              character: 'B',
              pronunciation: 'bee',
              example: 'Ball',
              usageTips: ['Draw vertical line first', 'Add curves on right'],
            ),
            ContentItem(
              character: 'C',
              pronunciation: 'see',
              example: 'Cat',
              usageTips: ['Single curved line', 'Start from top'],
            ),
            ContentItem(
              character: 'D',
              pronunciation: 'dee',
              example: 'Dog',
              usageTips: ['Vertical line first', 'Add curve on right'],
            ),
            ContentItem(
              character: 'E',
              pronunciation: 'ee',
              example: 'Elephant',
              usageTips: ['Vertical line first', 'Add three horizontal lines'],
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Numbers',
        description: 'Learn numbers in English',
        content: ChapterContent(
          title: 'English Numbers',
          items: [
            ContentItem(character: '1', pronunciation: 'One', example: 'First'),
            ContentItem(
              character: '2',
              pronunciation: 'Two',
              example: 'Second',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Greetings',
        description: 'Common greetings',
        content: ChapterContent(
          title: 'English Greetings',
          items: [
            ContentItem(
              character: 'Hello',
              pronunciation: 'heh-loh',
              example: 'Hi/Hey',
            ),
            ContentItem(
              character: 'Goodbye',
              pronunciation: 'good-bahy',
              example: 'Bye/See you',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Common Expressions',
        description: 'Essential everyday expressions',
        content: ChapterContent(
          title: 'Daily Expressions',
          items: [
            ContentItem(
              character: 'How are you?',
              pronunciation: 'how-ar-yoo',
              example: 'Asking about well-being',
            ),
            ContentItem(
              character: 'Nice to meet you',
              pronunciation: 'nys-too-meet-yoo',
              example: 'First time meeting',
            ),
            ContentItem(
              character: 'Have a good day',
              pronunciation: 'hav-uh-good-day',
              example: 'Wishing someone well',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Food & Drinks',
        description: 'Learn food and drink related words',
        content: ChapterContent(
          title: 'Food & Drinks',
          items: [
            ContentItem(
              character: 'Water',
              pronunciation: 'waw-ter',
              example: 'H2O / Drinking water',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Family Members',
        description: 'Learn family relation terms',
        content: ChapterContent(
          title: 'Family Members',
          items: [
            ContentItem(
              character: 'Mother',
              pronunciation: 'muh-ther',
              example: 'Female parent',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Colors & Shapes',
        description: 'Learn colors and basic shapes',
        content: ChapterContent(
          title: 'Colors & Shapes',
          items: [
            ContentItem(
              character: 'Red',
              pronunciation: 'red',
              example: 'Color of apple',
            ),
            ContentItem(
              character: 'Blue',
              pronunciation: 'bloo',
              example: 'Color of sky',
            ),
            ContentItem(
              character: 'Circle',
              pronunciation: 'sur-kul',
              example: 'Round shape',
            ),
            ContentItem(
              character: 'Square',
              pronunciation: 'skwair',
              example: 'Four equal sides',
            ),
          ],
        ),
      ),
      Chapter(
        title: 'Days & Months',
        description: 'Learn days and months',
        content: ChapterContent(
          title: 'Days & Months',
          items: [
            ContentItem(
              character: 'Monday',
              pronunciation: 'muhn-dey',
              example: 'First day of the week',
            ),
            ContentItem(
              character: 'Tuesday',
              pronunciation: 'tooz-dey',
              example: 'Second day of the week',
            ),
            ContentItem(
              character: 'Wednesday',
              pronunciation: 'wenz-dey',
              example: 'Third day of the week',
            ),
            ContentItem(
              character: 'Thursday',
              pronunciation: 'thurz-dey',
              example: 'Fourth day of the week',
            ),
            ContentItem(
              character: 'Friday',
              pronunciation: 'fry-dey',
              example: 'Fifth day of the week',
            ),
            ContentItem(
              character: 'Saturday',
              pronunciation: 'sa-tur-dey',
              example: 'Sixth day of the week',
            ),
            ContentItem(
              character: 'Sunday',
              pronunciation: 'suhn-dey',
              example: 'Seventh day of the week',
            ),
            // Months
            ContentItem(
              character: 'January',
              pronunciation: 'jan-yoo-eh-ree',
              example: 'First month',
            ),
            ContentItem(
              character: 'February',
              pronunciation: 'feb-roo-eh-ree',
              example: 'Second month',
            ),
            ContentItem(
              character: 'March',
              pronunciation: 'maarch',
              example: 'Third month',
            ),
            ContentItem(
              character: 'April',
              pronunciation: 'ey-pruhl',
              example: 'Fourth month',
            ),
            ContentItem(
              character: 'May',
              pronunciation: 'mey',
              example: 'Fifth month',
            ),
            ContentItem(
              character: 'June',
              pronunciation: 'joon',
              example: 'Sixth month',
            ),
            ContentItem(
              character: 'July',
              pronunciation: 'juh-ly',
              example: 'Seventh month',
            ),
            ContentItem(
              character: 'August',
              pronunciation: 'aw-guhst',
              example: 'Eighth month',
            ),
            ContentItem(
              character: 'September',
              pronunciation: 'sep-tem-ber',
              example: 'Ninth month',
            ),
            ContentItem(
              character: 'October',
              pronunciation: 'ok-toh-ber',
              example: 'Tenth month',
            ),
            ContentItem(
              character: 'November',
              pronunciation: 'noh-vem-ber',
              example: 'Eleventh month',
            ),
            ContentItem(
              character: 'December',
              pronunciation: 'dee-sem-ber',
              example: 'Twelfth month',
            ),
          ],
        ),
      ),
    ],
  );

  final _progressService = ProgressService();

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completedChapters = await _progressService.getProgress('english');
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
    await _progressService.saveProgress('english', completedChapters);
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
      appBar: buildThemedAppBar(context, 'Learn English'),
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
