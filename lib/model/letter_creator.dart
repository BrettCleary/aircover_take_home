import 'dart:async';

class LetterCreator {
  final StreamController<String> _letterTextController = StreamController<String>.broadcast();
  Stream<String> get letterTextStream => _letterTextController.stream;

  void updateLetterText(int height) {
    StringBuffer letterText = new StringBuffer();

    int width = (height / 4).ceil();
    int crossHeightIndex = (height / 2).floor();
    for (int i = height - 1; i >= 0; --i) {
      int aForwardStart = i;
      int aForwardEnd = aForwardStart + width;
      //last A index = height - 1 + width - 1 + height - 1 - i
      int aBackStart = 2 * height - 2 - i;
      int aBackEnd = aBackStart + width;
      for (int j = 0; j < aBackEnd; ++j) {
        if ((j >= aForwardStart && j < aForwardEnd) ||
            (j >= aBackStart && j < aBackEnd) ||
            (i == height - 1 - crossHeightIndex && j >= aForwardStart && j < aBackEnd)) {
          letterText.write('A');
        } else {
          letterText.write(' ');
        }
      }
      letterText.write('\n');
    }

    _letterTextController.add(letterText.toString());
  }
}
