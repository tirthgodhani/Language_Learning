import 'package:flutter/material.dart';

class Language {
  final String name;
  final dynamic imageUrl; // Changed to dynamic to support IconData
  final List<Chapter> chapters;
  double progress;

  Language({
    required this.name,
    required this.imageUrl,
    required this.chapters,
    this.progress = 0.0,
  });
}

class Chapter {
  final String title;
  final String description;
  final ChapterContent content;
  bool isCompleted;

  Chapter({
    required this.title,
    required this.description,
    required this.content,
    this.isCompleted = false,
  });
}

class ChapterContent {
  final String title;
  final List<ContentItem> items;

  ChapterContent({required this.title, required this.items});
}

class ContentItem {
  final String character;
  final String pronunciation;
  final String? example;
  final List<String>? usageTips;
  final String? writingOrder;
  final String? audioUrl; // For pronunciation audio files

  ContentItem({
    required this.character,
    required this.pronunciation,
    this.example,
    this.usageTips,
    this.writingOrder,
    this.audioUrl,
  });
}
