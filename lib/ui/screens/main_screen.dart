import 'package:flash_card/utils/imports.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void deleteForm(BuildContext context, {int? index}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete This Card ?"),
        actions: [
          TextButton(
            style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.black)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.black)),
            onPressed: () {
              setState(() {
                cardController.deleteEntry(index!);
                Navigator.of(context).pop();
              });
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text("Flash Cards"),
        ),
        body: cardController.carddata.isEmpty
            ? const Center(
                child: Text(
                "No flash Cards Yet",
                style: TextStyle(fontSize: 20),
              ))
            : ListView.builder(
                itemCount: cardController.carddata.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: height / 4,
                      width: widht / 8,
                      child: FlipCard(
                        front: Card(
                          elevation: 6,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PopupMenuButton(
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: ListTile(
                                          title: const Text("Edit"),
                                          onTap: () {
                                            showForm(context, index: index);
                                          },
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: ListTile(
                                          title: const Text("Delete"),
                                          onTap: () {
                                            deleteForm(context, index: index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    cardController.carddata[index].question,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        back: Card(
                          elevation: 6,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                cardController.carddata[index].answer,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showForm(
            context,
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
