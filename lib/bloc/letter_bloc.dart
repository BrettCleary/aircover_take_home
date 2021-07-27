import 'dart:async';
import 'package:aircover_take_home/bloc/bloc.dart';
import 'package:aircover_take_home/model/letter_creator.dart';

class LetterBloc implements Bloc {
  LetterCreator _letterCreator;

  final StreamController<String> _letterTextController = StreamController<String>.broadcast();
  Stream<String> get letterTextStream => _letterTextController.stream;

  LetterBloc(this._letterCreator);

  void updateLetter(int height) {
    _letterCreator.updateLetterText(height);
    _letterCreator.letterTextStream.listen(letterTextUpdatedHandler);
  }

  void letterTextUpdatedHandler(String letterText) {
    _letterTextController.add(letterText);
  }

  @override
  dispose() {
    _letterTextController.sink.close();
  }
}
