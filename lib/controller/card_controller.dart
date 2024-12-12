import 'package:flash_card/utils/imports.dart';

class CardController {
  List<FlashcardModel> carddata = List.empty(growable: true);
  void addEntry(String question, String answer) {
    if (question.isEmpty || answer.isEmpty) {}
    carddata.add(FlashcardModel(answer: answer, question: question));
  }

  void updateEntry(int index, String question, String answer) {
    carddata[index] = FlashcardModel(answer: answer, question: question);
  }

  void deleteEntry(int index) {
    carddata.removeAt(index);
  }
}
