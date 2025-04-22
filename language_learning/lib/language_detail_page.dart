import 'package:flutter/material.dart';
import '../models/language.dart';
import 'chapter_content_page.dart';

class LanguageDetailPage extends StatefulWidget {
  final Language language;

  const LanguageDetailPage({super.key, required this.language});

  @override
  State<LanguageDetailPage> createState() => _LanguageDetailPageState();
}

class _LanguageDetailPageState extends State<LanguageDetailPage> {
  void _updateProgress() {
    final completedChapters =
        widget.language.chapters.where((c) => c.isCompleted).length;
    final totalChapters = widget.language.chapters.length;
    setState(() {
      widget.language.progress =
          totalChapters > 0 ? completedChapters / totalChapters : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.language.name} Learning'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade50, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Progress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: widget.language.progress,
                    minHeight: 10,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  Text('${(widget.language.progress * 100).toInt()}%'),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.language.chapters.length,
                itemBuilder: (context, index) {
                  final chapter = widget.language.chapters[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
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
                                        languageName: widget.language.name,
                                      ),
                                ),
                              );
                            },
                          ),
                          Checkbox(
                            value: chapter.isCompleted,
                            onChanged: (value) {
                              setState(() {
                                chapter.isCompleted = value ?? false;
                                _updateProgress();
                              });
                            },
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
