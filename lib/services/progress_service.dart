import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/language.dart';

class ProgressService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> saveProgress(
    String language,
    List<String> completedChapters,
  ) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('progress').doc(user.uid).set({
        language: completedChapters,
      }, SetOptions(merge: true));
    }
  }

  Future<List<String>> getProgress(String language) async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('progress').doc(user.uid).get();
      if (doc.exists && doc.data()!.containsKey(language)) {
        return List<String>.from(doc.data()![language]);
      }
    }
    return [];
  }
}
