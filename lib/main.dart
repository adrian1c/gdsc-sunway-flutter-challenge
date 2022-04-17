import 'package:flutter/material.dart';

void main() {
  run App(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme:
              ThemeData().colorScheme.copyWith(primary: Colors.grey[800]),
          appBarTheme: AppBarTheme(color: Colors.grey[800], centerTitle: true),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
              textStyle: MaterialStateProperty.all(
                const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          textTheme: const TextTheme(
              bodyText2: TextStyle(
            fontFamily: 'RobotoMono',
          ))),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final inputText = TextEditingController();

  List<String> items = ['Eggs', 'Milk', 'Banana'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home Page')),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
          child: Column(
            child: [
              const Text('Generic Grocery List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Divider(),
              Flexible(
                fit: FlexFit.loose,
                child: TextField(
                  controller: inputText,
                  decoration: const InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Enter item',
                    hintText: 'Item name',
                    prefixIcon: Icon(Icons.local_grocery_store),
                  ),
                ),
              ),
              Padding(
                pad: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    if (inputText.text != '') {
                      // inputText.text is the current String in the field
                      items.add(inputText.text);
                      inputText.clear();
                    }
                  },
                ),
              ),
              const Divider(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(132, 60, 67, 70),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView.builder(
                      itemCount: items.length + 1,
                      itemBuilder: (context, index) {
                        // If list is empty, show this
                        if (items.isEmpty) {
                          return const Center(child: Text('No items'));
                        }

                        // If reached the end of list, show this
                        if (index == items.length) {
                          return Column(
                            children: const [
                              Divider(),
                              Center(child: Text('End of List')),
                            ],
                          );
                        }

                        // If the two conditions above are not met, show this by default
                        return Material(
                          color: null,
                          borderRadius: null,
                          child: ListTile(
                            title: Text(items[index],
                                style:
                                    const TextStyle(fontFamily: 'RobotoMono')),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  items.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text('Delete All'),
                  onPressed: () {
                    setState(() {
                      items = ['Eggs', 'Milk', 'Banana'];
                    });
                  },
                ),
              )
            ],
          ),
        ));
  }
}
