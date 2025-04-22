import 'package:flutter/material.dart';

mixin PageThemeMixin {
  ThemeData getTheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: isDark ? Colors.grey[900] : Colors.white,
      cardColor: isDark ? Colors.grey[800] : Colors.white,
      dividerColor: isDark ? Colors.grey[700] : Colors.grey[300],
    );
  }

  AppBar buildThemedAppBar(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      title: Text(title),
      backgroundColor: isDark ? Colors.grey[850] : Colors.blue,
      foregroundColor: Colors.white,
      elevation: isDark ? 0 : 4,
    );
  }

  BoxDecoration getPageDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      gradient: LinearGradient(
        colors:
            isDark
                ? [Colors.grey[900]!, Colors.grey[850]!]
                : [Colors.blue.shade50, Colors.purple.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Card buildThemedCard(BuildContext context, Widget child) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: isDark ? 2 : 4,
      color: isDark ? Colors.grey[800] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isDark ? Colors.grey[700]! : Colors.transparent,
          width: 1,
        ),
      ),
      child: child,
    );
  }

  BoxDecoration getPageBackgroundDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      gradient: LinearGradient(
        colors:
            isDark
                ? [Colors.grey[900]!, Colors.grey[850]!]
                : [Colors.blue.shade50, Colors.purple.shade50],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  TextStyle getPracticeWordStyle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.bold,
        ) ??
        const TextStyle();
  }

  BoxDecoration getPracticeWordContainerDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? Colors.grey[800] : Colors.white,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
