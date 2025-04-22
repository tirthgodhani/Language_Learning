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
  @override
  void initState() {
    super.initState();
    _updateProgress(); // Initialize progress when page loads
  }

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
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: Colors.blue.shade700,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Learning Progress',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              widget.language.progress == 1.0
                                  ? Colors.green.shade100
                                  : Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                widget.language.progress == 1.0
                                    ? Colors.green.shade300
                                    : Colors.blue.shade200,
                          ),
                        ),
                        child: Text(
                          '${(widget.language.progress * 100).toInt()}%',
                          style: TextStyle(
                            color:
                                widget.language.progress == 1.0
                                    ? Colors.green.shade700
                                    : Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: widget.language.progress,
                          minHeight: 16,
                          backgroundColor: Colors.grey.shade100,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.language.progress == 1.0
                                ? Colors.green
                                : Colors.blue.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.language.chapters.where((c) => c.isCompleted).length} of ${widget.language.chapters.length} Chapters',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (widget.language.progress == 1.0)
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green.shade500,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Completed!',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
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
