import 'package:hive/hive.dart';
import 'HiveTypeId.dart';

part 'Word.g.dart';

@HiveType(typeId: HiveTypeId.WORD)
class Word extends HiveObject {
  Word(this.source, this.translate);

  @HiveField(0)
  String source;

  @HiveField(1)
  String translate;

  @override
  String toString() {
    return '$source: $translate';
  }
}
