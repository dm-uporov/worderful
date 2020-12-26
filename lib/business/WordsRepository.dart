import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:words_remember/model/Word.dart';

class WordsRepository {
  static const String REPO_NAME = "words";

  static Box<Word> _box = Hive.box<Word>(REPO_NAME);

  static Future preinitWords() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('words').get();

    if (snapshot.docs.isEmpty) return;

    final remoteDictionary = snapshot.docs.map((doc) {
      final data = doc.data();
      return Word(
        data['en'],
        data['ru'],
        pronunciation: data['ruPronunciation'],
        translateSynonymous: data['ruSynonymous']?.cast<String>(),
        sourceSynonymous: data['enSynonymous']?.cast<String>(),
        isIdiom: data['isIdiom'],
        firebaseId: doc.id,
      );
    });

    final Map<String, Word> idToWordMap = Map.fromIterable(remoteDictionary,
        key: (item) => item.firebaseId, value: (item) => item);
    _box.putAll(idToWordMap);
  }

  static Future addWord(Word word) async {
    await _box.add(word);
  }

  static Future deleteWord(Word word) async {
    await _box.delete(word);
  }

  static List<Word> getWords() {
    return _box.values.toList();
  }

  static ValueListenable<Box<Word>> wordsListenable() {
    return _box.listenable();
  }
}
