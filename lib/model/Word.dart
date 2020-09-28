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

  @override
  String toString() {
    return '$source: $translate';
  }
}
