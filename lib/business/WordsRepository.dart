import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:words_remember/model/Word.dart';

final myDictionary = [
  Word('claims', 'заявлять'),
  Word('blame', 'винить'),
  Word('wardrobe', 'гардероб'),
  Word('ditto', 'то же самое'),
  Word('adorable', 'обожаемый'),
  Word('desperate', 'отчаянный'),
  Word('back me up', 'поддержи меня'),
  Word('on purpose', 'с целью'),
  Word('face it', 'смирись с этим'),
  Word('soak up', 'впитывать'),
  Word('tough', 'жёсткий', pronunciation: 'тоф'),
  Word('fancy', 'замаскированный'),
  Word('I have the edge', 'у меня есть преимущество'),
  Word('uptight', 'скованный'),
  Word('terrific', 'потрясающий'),
  Word('prissy twit', 'мудак'),
  Word('deed', 'поступок'),
  Word('rude', 'грубый'),
  Word('admit', 'признавать'),
  Word('tore up', 'порвать'),
  Word('violation', 'нарушение'),
  Word('gullible', 'доверчивый'),
  Word('ahead', 'впереди'),
  Word('man of the cloth', 'священнослужитель',
      translateSynonymous: ['духовное лицо']),
  Word('weird', 'странный', sourceSynonymous: ['odd']),
  Word('I do not mind', 'я не против'),
  Word('bummer', 'лентяй'),
  Word('betray', 'предавать'),
  Word('fair enough', 'справедливо',
      translateSynonymous: ['достаточно честно, достаточно справедливо']),
  Word('betray', 'предавать'),
  Word('hang out', 'тусоваться'),
  Word('guilt', 'чувствовать вину', translateSynonymous: ['чувство вины']),
  Word('miracle', 'чудо', sourceSynonymous: ['wonder', 'marvel']),
  Word('promise', 'обещать'),
  Word('my treat', 'я угощаю'),
  Word('gorgeous', 'великолепный', translateSynonymous: ['прекрасный']),
  Word('tone it down', 'понизь тон', translateSynonymous: ['полегче']),
  Word('couch', 'диван', pronunciation: 'кауч'),
  Word('coach', 'тренер', pronunciation: 'коуч'),
  Word('pile', 'куча'),
  Word('mess', 'беспорядок', translateSynonymous: ['бардак']),
  Word('screwed over', 'облажался'),
  Word('appreciate', 'ценить'),
  Word('get rid', 'избавиться'),
  Word('fork it over', 'раскошелиться'),
  Word('the coin toss', 'подбрасывание монеты'),
  Word('pet peeves', 'больная тема', translateSynonymous: ['любимые раздражители']),
  Word('by the by', 'кстати'),
  Word('fabulous', 'невероятный'),
  Word('convince', 'убеждать'),
  Word('fair and square', 'по-честному'),
  Word('hasty', 'поспешный'),
  Word('hang in there', 'держитесь там'),
  Word('stay up', 'бодрствовать', translateSynonymous: ['не ложиться спать']),
  Word('engage', 'заниматься'),
  Word('engagement', 'помолвка'),
  Word('sudden', 'внезапно', translateSynonymous: ['неожиданно']),
  Word('neat', 'аккуратный'),
  Word('passion', 'страсть'),
  Word('yell', 'кричать'),
  Word('flaws', 'недостатки', translateSynonymous: ['изъяны']),
  Word('trap', 'ловушка'),
  Word('feel left out', 'чувстввать себя обеделнным'),
  Word('confidence', 'уверенность'),
  Word('awkward', 'неловко'),
  Word('offensive', 'оскорбительно'),
  Word('even though', 'даже если'),
  Word('favor', 'одолжение'),
  Word('borrow', 'заимствовать', translateSynonymous: ['занимать']),
  Word('annual', 'ежегодный'),
  Word('apparently', 'видимо'),
  Word('take a nap', 'вздремнуть'),
  Word('faith', 'вера'),
  Word('barely', 'едва'),
];

class WordsRepository {
  static const String REPO_NAME = "words";

  static Box<Word> _box = Hive.box<Word>(REPO_NAME);

  static Future preinitWords() async {
    if (getWords().isEmpty) {
      _box.addAll(myDictionary);
    }
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
