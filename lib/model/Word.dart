import 'package:hive/hive.dart';
import 'HiveTypeId.dart';

part 'Word.g.dart';

@HiveType(typeId: HiveTypeId.WORD)
class Word extends HiveObject {
  Word(
    this.source,
    this.translate, {
    this.pronunciation,
    this.sourceSynonymous = const [],
    this.translateSynonymous = const [],
    this.isIdiom = false,
    this.firebaseId = NO_ID,
  });

  @HiveField(0)
  String source;

  @HiveField(1)
  String translate;

  @HiveField(2)
  String pronunciation;

  @HiveField(3)
  List<String> sourceSynonymous;

  @HiveField(4)
  List<String> translateSynonymous;

  @HiveField(5)
  bool isIdiom;

  @HiveField(6)
  String firebaseId;

  @override
  String toString() {
    return '$source: $translate';
  }

  @override
  bool operator ==(Object other) {
    return other is Word && source == other.source;
  }

  @override
  int get hashCode {
    return source.hashCode;
  }
}

const String NO_ID = "NO_ID";