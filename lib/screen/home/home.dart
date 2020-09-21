import 'package:flutter/material.dart';
import 'package:words_remember/resources/colors.dart';
import 'package:words_remember/screen/home/new_word.dart';
import 'package:words_remember/screen/home/trainings.dart';
import 'package:words_remember/screen/home/statistics.dart';
import 'package:words_remember/screen/home/words_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.initScreenId = 0, Key key}) : super(key: key);
  final int initScreenId;

  @override
  _HomeScreenState createState() => _HomeScreenState(initScreenId);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState(this._selectedIndex);

  int _selectedIndex;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedScreen = Screen.values[_selectedIndex];
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          selectedScreen.title,
          style: TextStyle(color: solidColor),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: Screen.values.map((e) => e.widget).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        currentIndex: _selectedIndex,
        selectedItemColor: accentColor,
        unselectedItemColor: neutralColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            title: Text('Тренировка'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            title: Text('Статистика'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add),
            title: Text('Список слов'),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.playlist_add_rounded),
          //   title: Text('Добавить'),
          // ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

enum Screen { TRAINING, STATISTICS, WORDS_LIST, NEW_WORD }

extension ScreenExtension on Screen {
  static const Widget _trainingWidget = TrainingScreen();
  static const Widget _statisticsWidget = StatisticsScreen();
  static const Widget _wordsListWidget = WordsListScreen();
  static const Widget _newWord = NewWordScreen();

  Widget get widget {
    switch (this) {
      case Screen.TRAINING:
        return _trainingWidget;
      case Screen.STATISTICS:
        return _statisticsWidget;
      case Screen.WORDS_LIST:
        return _wordsListWidget;
      case Screen.NEW_WORD:
        return _newWord;
      default:
        return null;
    }
  }

  String get title {
    switch (this) {
      case Screen.TRAINING:
        return 'Тренировка';
      case Screen.STATISTICS:
        return 'Статистика';
      case Screen.WORDS_LIST:
        return 'Список слов';
      // case Screen.NEW_WORD:
      //   return 'Добавить слово';
      default:
        return null;
    }
  }
}
