import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:words_remember/model/Word.dart';

class WordsRepository {
  static const String REPO_NAME = "words";

  static Box<Word> _box = Hive.box<Word>(REPO_NAME);

  static Future addWord(Word word) async {
    await _box.add(word);
  }

  static List<Word> getWords() {
    return _box.values.toList();
  }

  static ValueListenable<Box<Word>> wordsListenable() {
    return _box.listenable();
  }
}
