import 'package:flutter/material.dart';
import 'package:words_remember/business/WordsRepository.dart';
import 'package:words_remember/model/Word.dart';
import 'package:words_remember/resources/colors.dart';
import 'package:words_remember/utils/BrightIcon.dart';
import 'package:words_remember/utils/container/NeumorphicClickableContainer.dart';
import 'package:words_remember/utils/container/NeumorphicContainer.dart';

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

  final textStyle = TextStyle(color: solidColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: solidColor)),
              labelText: 'Слово / словосочетание',
              fillColor: solidColor,
              labelStyle: textStyle,
            ),
            onChanged: _onWordChanged,
            cursorColor: solidColor,
            style: textStyle,
            enabled: !_loading,
            controller: _wordController,
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: solidColor)),
              labelText: 'Перевод на русский',
              fillColor: solidColor,
              labelStyle: textStyle,
            ),
            onChanged: _onTranslateChanged,
            cursorColor: solidColor,
            style: textStyle,
            enabled: !_loading,
            controller: _translateController,
          ),
          Padding(padding: EdgeInsets.only(top: 48.0)),
          NeumorphicClickableContainer(
            style: NeumorphicStyle(radius: 64, blurRadius: 3, elevation: 0.1),
            onTap: _onAddClicked,
            childBuilder: (pressProgress) {
              return Padding(
                padding: EdgeInsets.all(32),
                child: BrightIcon(
                  icon: Icons.add,
                  solidColor: colorByProgress(progress: pressProgress),
                  brightnessColor: cycleBlueAccent.withOpacity(pressProgress),
                ),
              );
            },
          ),
        ],
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
