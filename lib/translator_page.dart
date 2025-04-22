import 'package:flutter/material.dart';
import 'services/translation_service.dart';
import 'theme/page_theme_mixin.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> with PageThemeMixin {
  final _translationService = TranslationService();
  final _textController = TextEditingController();
  String _translatedText = '';
  bool _isLoading = false;
  String _fromLanguage = 'en';
  String _toLanguage = 'hi';

  Future<void> _translateText() async {
    if (_textController.text.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final translated = await _translationService.translate(
        text: _textController.text,
        targetLanguage: _toLanguage,
        sourceLanguage: _fromLanguage,
      );

      setState(() {
        _translatedText = translated;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Translation error: $e')));
    }
  }

  void _swapLanguages() {
    setState(() {
      final temp = _fromLanguage;
      _fromLanguage = _toLanguage;
      _toLanguage = temp;
      _textController.text = _translatedText;
      _translatedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: getTheme(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Translator'),
          backgroundColor: isDark ? Colors.grey[850] : Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Container(
          decoration: getPageDecoration(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildThemedCard(
                  context,
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: _fromLanguage,
                            items:
                                TranslationService.supportedLanguages.entries
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.key,
                                        child: Text(e.value),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() => _fromLanguage = value!);
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.swap_horiz),
                          onPressed: _swapLanguages,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value: _toLanguage,
                            items:
                                TranslationService.supportedLanguages.entries
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.key,
                                        child: Text(e.value),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() => _toLanguage = value!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                buildThemedCard(
                  context,
                  TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter text to translate',
                      contentPadding: EdgeInsets.all(16),
                      border: InputBorder.none,
                    ),
                    maxLines: 4,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isLoading ? null : _translateText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Translate'),
                ),
                const SizedBox(height: 16),
                if (_translatedText.isNotEmpty)
                  buildThemedCard(
                    context,
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _translatedText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
