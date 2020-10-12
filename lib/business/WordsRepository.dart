import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:words_remember/model/Word.dart';

final myDictionary = [
  Word('to claim', 'требовать', sourceSynonymous: ['заявлять']),
  Word('to blame', 'винить'),
  Word('wardrobe', 'гардероб'),
  Word('ditto', 'то же самое'),
  Word('adorable', 'обожаемый'),
  Word('desperate', 'отчаянный'),
  Word('back me up', 'поддержи меня'),
  Word('on purpose', 'с целью'),
  Word('to soak up', 'впитывать'),
  Word('tough', 'жёсткий', pronunciation: 'тоф'),
  Word('fancy', 'замаскированный'),
  Word('I have the edge', 'у меня есть преимущество'),
  Word('uptight', 'скованный'),
  Word('terrific', 'потрясающий'),
  Word('prissy twit', 'мудак'),
  Word('deed', 'поступок'),
  Word('rude', 'грубый'),
  Word('to hunt down', 'выследить'),
  Word('plague', 'чума', translateSynonymous: ['пандемия']),
  Word('to admit', 'признавать'),
  Word('to tore up', 'порвать'),
  Word('violation', 'нарушение'),
  Word('gullible', 'доверчивый'),
  Word('ahead', 'впереди'),
  Word('man of the cloth', 'священнослужитель',
      translateSynonymous: ['духовное лицо']),
  Word('weird', 'странный', sourceSynonymous: ['odd']),
  Word('I do not mind', 'я не против'),
  Word('bummer', 'лентяй'),
  Word('fair enough', 'справедливо',
      translateSynonymous: ['достаточно честно, достаточно справедливо']),
  Word('to betray', 'предавать'),
  Word('to hang out', 'тусоваться'),
  Word('to guilt', 'чувствовать вину', translateSynonymous: ['чувство вины']),
  Word('miracle', 'чудо', sourceSynonymous: ['wonder', 'marvel']),
  Word('to promise', 'обещать'),
  Word('my treat', 'я угощаю'),
  Word('gorgeous', 'великолепный', translateSynonymous: ['прекрасный']),
  Word('to tone it down', 'понизить тон'),
  Word('couch', 'диван', pronunciation: 'кауч'),
  Word('coach', 'тренер', pronunciation: 'коуч'),
  Word('pile', 'куча'),
  Word('mess', 'беспорядок', translateSynonymous: ['бардак']),
  Word('screwed over', 'облажался'),
  Word('to appreciate', 'ценить'),
  Word('to get rid', 'избавиться'),
  Word('to fork it over', 'раскошелиться'),
  Word('the coin toss', 'подбрасывание монеты'),
  Word('pet peeves', 'больная тема',
      translateSynonymous: ['любимые раздражители']),
  Word('by the by', 'кстати'),
  Word('fabulous', 'невероятный'),
  Word('convince', 'убеждать'),
  Word('fair and square', 'по-честному'),
  Word('hasty', 'поспешный'),
  Word('hang in there', 'держитесь там'),
  Word('to stay up', 'бодрствовать',
      translateSynonymous: ['не ложиться спать']),
  Word('to engage', 'заниматься'),
  Word('engagement', 'помолвка'),
  Word('sudden', 'внезапно', translateSynonymous: ['неожиданно']),
  Word('neat', 'аккуратный'),
  Word('passion', 'страсть'),
  Word('to yell', 'кричать'),
  Word('flaws', 'недостатки', translateSynonymous: ['изъяны']),
  Word('trap', 'ловушка'),
  Word('confidence', 'уверенность'),
  Word('awkward', 'неловко'),
  Word('offensive', 'оскорбительно'),
  Word('even though', 'даже если'),
  Word('favor', 'одолжение'),
  Word('to borrow', 'заимствовать', translateSynonymous: ['занимать']),
  Word('annual', 'ежегодный'),
  Word('apparently', 'видимо'),
  Word('to take a nap', 'вздремнуть'),
  Word('faith', 'вера'),
  Word('tastefully', 'со вкусом'),
  Word('barely', 'едва'),
  Word('turtleneck', 'водолазка'),
  Word('to carve', 'вырезать'),
  Word('to pin down', 'придавить'),
  Word('to tickle', 'щекотать'),
  Word('lewd', 'непристойный'),
  Word('hangover', 'похмелье'),
  Word('tense', 'напряженный'),
  Word('posture', 'осанка'),
  Word('heel', 'каблук'),
  Word('to elope', 'сбежать'),
  Word('bulb', 'лампочка'),
  Word('fuss', 'суета'),
  Word('fugitive', 'беглец'),
  Word('striker', 'забастовщик'),
  Word('hostage', 'заложник'),
  Word('arrangement', 'договоренность'),
  Word('disaster', 'катастрофа'),
  Word('violent', 'жестокий'),
  Word('gossip', 'сплетня'),
  Word('to chat', 'разговор ни о чем'),
  Word('to boast', 'хвастаться'),
  Word('to moan', 'жаловаться', translateSynonymous: ['ныть', 'нудеть']),
  Word('to warn', 'советовать', translateSynonymous: ['поучать', 'предостерегать']),
  Word('thief', 'вор'),
  Word('burglar', 'грабитель'),
  Word('inappropriate', 'неуместный'),
  Word('nosy', 'любопытный', pronunciation: 'ноУзи'),
  Word('hilarious', 'весёлый',
      sourceSynonymous: ['very funny'], translateSynonymous: ['смешной']),
  Word('get in line', 'встать в очередь'),
  Word('a peck on the cheek', 'чмокнуть в щёку'),
  Word('feel left out', 'чувстввать себя обеделнным', isIdiom: true),
  Word('wafer-thin ice', 'тонкий лёд', isIdiom: true),
  Word('not a close one', 'даже не близко', isIdiom: true),
  Word('close to my heart', '', isIdiom: true),
  Word('running out of time', '', isIdiom: true),
  Word('this hits the nail on the head', '', isIdiom: true),
  Word('let`s face it', 'смирись с этим', isIdiom: true),
  Word('in hot water', 'в рискованной ситуации', isIdiom: true),
  Word('put my foot in it', 'оказался в неловкой ситуации', isIdiom: true),
  Word('working against the clock', 'время работает против нас', isIdiom: true),
  Word('keep an eye on him', 'следи за ним', isIdiom: true),
  Word('give me a hand', 'помоги мне', isIdiom: true),
  Word('it is not my cup of tea', 'это не по мне', isIdiom: true),
  Word('a piece of cake', 'очень просто', isIdiom: true),
  Word('a dark horse', 'тёмная лошадка', isIdiom: true),
  Word('the rat race', 'соревновательный мир карьеристов', isIdiom: true),
  Word('What’s the catch?', 'в чём подвох?', isIdiom: true),
  Word('(by accident) spill the beans', '(случайно) выдать секрет',
      isIdiom: true),
  Word('learn something by heart', 'выучить наизусть', isIdiom: true),
  Word('be in two minds', 'быть в ситуации, когда сложно принять решение',
      isIdiom: true),
  Word('break the ice', 'разрядить обстановку', isIdiom: true),
  Word('travels light', 'путешествовать налегке', isIdiom: true),
  Word('go window shopping', 'пойти по магазинам посмотреть (не покупая)',
      isIdiom: true),
  Word('let your hair down', 'развеяться, затусить', isIdiom: true),
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
