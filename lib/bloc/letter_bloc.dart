import 'dart:async';
import 'package:aircover_take_home/bloc/bloc.dart';
import 'package:aircover_take_home/model/letter_creator.dart';

//LetterBloc is provided to children widgets through a provider pattern
//LetterBloc provides a layer of indirection and decouples the views from the business logic of creating AC from A's and C's
class LetterBloc implements Bloc {
  LetterCreator _letterCreator;

  final StreamController<String> _letterTextController = StreamController<String>.broadcast();
  Stream<String> get letterTextStream => _letterTextController.stream;

  LetterBloc(this._letterCreator){
    _letterCreator.letterTextStream.listen(letterTextUpdatedHandler);
  }

  void updateLetter(int height) {
    _letterCreator.updateLetterText(height);
  }

  void letterTextUpdatedHandler(String letterText) {
    _letterTextController.add(letterText);
  }

  @override
  dispose() {
    _letterTextController.sink.close();
  }
}
