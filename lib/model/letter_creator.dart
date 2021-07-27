import 'dart:async';

//LetterCreator is the business logic for building the AC
//LetterCreator updates AC by adding a string to letterTextStream
class LetterCreator {
  final StreamController<String> _letterTextController = StreamController<String>.broadcast();
  Stream<String> get letterTextStream => _letterTextController.stream;

  //write letters into string buffer and add to stream as string after
  void updateLetterText(int height) {
    StringBuffer letterText = new StringBuffer();

    int width = (height / 4).ceil();
    int crossHeightIndex = (height / 2).floor();
    int bigLetterSpacing = 4;
    int letterAWidth = 2 * height - 2 + width;
    for (int i = height - 1; i >= 0; --i) {
      writeALetters(i, width, height, letterAWidth, crossHeightIndex, letterText);

      for (int k = 0; k < bigLetterSpacing; ++k) {
        letterText.write(' ');
      }

      writeCLetters(i, height, width, letterText);
      letterText.write('\n');
    }

    _letterTextController.add(letterText.toString());
  }

  //write one row of C letters
  void writeCLetters(int rowIndex, int height, int width, StringBuffer letterText) {
    int letterCWidth = height + width;
    int startCIndex = 0;
    int endCIndex = 0;
    if (rowIndex > height - 1 - width) {
      int rowsFromTop = height - 1 - rowIndex;
      startCIndex = width - rowsFromTop;
      int rowsFromInnerHorizontal = (width - 1 - rowsFromTop);
      endCIndex = width + height - rowsFromInnerHorizontal;
    } else if (rowIndex >= width) {
      startCIndex = 0;
      endCIndex = width;
    } else {
      int rowsFromBottom = rowIndex;
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
  }

  //write one row of A letters
  void writeALetters(int rowIndex, int width, int height, int letterAWidth, int crossHeightIndex, StringBuffer letterText) {
    int aForwardStart = rowIndex;
    int aForwardEnd = aForwardStart + width;
    //last A index = height - 1 + width - 1 + height - 1 - i
    int aBackStart = 2 * height - 2 - rowIndex;
    int aBackEnd = aBackStart + width;
    for (int j = 0; j < letterAWidth; ++j) {
      if ((j >= aForwardStart && j < aForwardEnd) ||
          (j >= aBackStart && j < aBackEnd) ||
          (rowIndex == height - 1 - crossHeightIndex && j >= aForwardStart && j < aBackEnd)) {
        letterText.write('A');
      } else {
        letterText.write(' ');
      }
    }
  }
}
