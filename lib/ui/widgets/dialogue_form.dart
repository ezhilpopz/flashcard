import 'package:flash_card/utils/imports.dart';

final TextEditingController questionController = TextEditingController();
final TextEditingController answerController = TextEditingController();
final cardController = CardController();

final _formkey = GlobalKey<FormState>();
void showForm(BuildContext context, {int? index}) {
  if (index != null) {
    questionController.text = cardController.carddata[index].question;
    answerController.text = cardController.carddata[index].answer;
  } else {
    questionController.clear();
    answerController.clear();
  }

  showModalBottomSheet(
      isScrollControlled: true,
      context: (context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Form(
              key: _formkey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  index == null ? 'Add Card' : 'Edit Card',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: questionController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Required This Field";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Question',
                      hintText: "eg., What is Flutter",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 18,
                ),
                TextFormField(
                  controller: answerController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Required This Field";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Answer',
                      hintText: "eg., Flutter is a OpenSource Framework",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: const ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.black)),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState?.validate() ?? false) {
                      final question = questionController.text.trim();
                      final answer = answerController.text.trim();

                      if (index == null) {
                        cardController.addEntry(question, answer);
                      } else {
                        cardController.updateEntry(index, question, answer);
                      }

                      Navigator.of(context).pop();
                    }
                  },
                  style: const ButtonStyle(
                      fixedSize: WidgetStatePropertyAll(Size(160, 60)),
                      foregroundColor: WidgetStatePropertyAll(Colors.black)),
                  child: Text(
                    index == null ? 'Add' : 'Update',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ]),
            ),
          ));
}
