import 'package:flutter/material.dart';
import 'package:words_remember/business/WordsRepository.dart';
import 'package:words_remember/model/Word.dart';

class NewWordScreen extends StatefulWidget {
  const NewWordScreen({Key key}) : super(key: key);

  @override
  _NewWordScreenState createState() => _NewWordScreenState();
}

class _NewWordScreenState extends State<NewWordScreen> {

  String _lastWord;
  String _lastTranslate;
  bool _loading = false;
  TextEditingController _wordController = TextEditingController();
  TextEditingController _translateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Слово / словосочетание',
              ),
              onChanged: _onWordChanged,
              enabled: !_loading,
              controller: _wordController,
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Перевод на русский',
              ),
              onChanged: _onTranslateChanged,
              enabled: !_loading,
              controller: _translateController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddClicked,
        tooltip: 'Добавить',
        child: Icon(Icons.add),
      ),
    );
  }

  void _onWordChanged(String newWord) {
    _lastWord = newWord;
  }

  void _onTranslateChanged(String newTranslate) {
    _lastTranslate = newTranslate;
  }

  void _onAddClicked() async {
    if (_lastWord == null || _lastWord.isEmpty) {

      return;
    }

    if (_lastTranslate == null || _lastTranslate.isEmpty) {

      return;
    }
    setState(() {
      _loading = true;
    });

    await WordsRepository.addWord(Word(_lastWord, _lastTranslate));
    setState(() {
      _lastWord = null;
      _lastTranslate = null;
      _loading = false;
      _wordController.clear();
      _translateController.clear();
      FocusScope.of(context).unfocus();
    });
  }
}
