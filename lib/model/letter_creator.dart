import 'dart:async';

class LetterCreator {
  final StreamController<String> _letterTextController = StreamController<String>.broadcast();
  Stream<String> get letterTextStream => _letterTextController.stream;

  void updateLetterText(int height) {
    StringBuffer letterText = new StringBuffer();

    int width = (height / 4).ceil();
    int crossHeightIndex = (height / 2).floor();
    int bigLetterSpacing = 4;
    int letterAWidth = 2 * height - 2 + width;
    for (int i = height - 1; i >= 0; --i) {
      int aForwardStart = i;
      int aForwardEnd = aForwardStart + width;
      //last A index = height - 1 + width - 1 + height - 1 - i
      int aBackStart = 2 * height - 2 - i;
      int aBackEnd = aBackStart + width;
      for (int j = 0; j < letterAWidth; ++j) {
        if ((j >= aForwardStart && j < aForwardEnd) ||
            (j >= aBackStart && j < aBackEnd) ||
            (i == height - 1 - crossHeightIndex && j >= aForwardStart && j < aBackEnd)) {
          letterText.write('A');
        } else {
          letterText.write(' ');
        }
      }

      for (int k = 0; k < bigLetterSpacing; ++k) {
        letterText.write(' ');
      }

      int letterCWidth = height + width;
      int lastColumnIndex = aBackEnd + bigLetterSpacing + height;
      int startCIndex = 0;
      int endCIndex = 0;
      if (i > height - 1 - width) {
        int rowsFromTop = height - 1 - i;
        startCIndex = width - rowsFromTop;
        int rowsFromInnerHorizontal = (width - 1 - rowsFromTop);
        endCIndex = width + height - rowsFromInnerHorizontal;
      } else if (i >= width) {
        startCIndex = 0;
        endCIndex = width;
      } else {
        int rowsFromBottom = i;
        startCIndex = width - rowsFromBottom;
        int rowsFromInnerHorizontal = (width - 1 - rowsFromBottom);
        endCIndex = width + height - rowsFromInnerHorizontal;
      }
      for (int k = 0; k < letterCWidth; ++k) {
        if (k >= startCIndex && k < endCIndex) {
          letterText.write('C');
        } else {
          letterText.write(' ');
        }
      }
      letterText.write('\n');
    }

    _letterTextController.add(letterText.toString());
  }
}
