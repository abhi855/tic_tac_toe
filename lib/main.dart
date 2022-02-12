import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/values.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,

      ),
      home: ChangeNotifierProvider<Values>(
        create: (_) => Values(),
        child: const MyHomePage(title: 'TIC-TAC-TOE'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Values _values = Provider.of<Values>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[600],
        elevation: 0.0,
        title: Center(child: Text(widget.title)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(Icons.refresh_outlined,
          color: Colors.deepPurple,
        ),
        onPressed: (){
          _values.reset();
        },
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.deepPurple
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 160,
                    child: Card(
                      child:ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/O.png'),
                        ),
                        title: const Text('Player A',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Consumer<Values>(
                          builder: (_,values,__)=>Text(values.pl0.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50,),
                  SizedBox(
                    width: 160,
                    child: Card(
                      child:ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/X.png'),
                        ),
                        title: const Text('Player B',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Consumer<Values>(
                          builder: (_,values,__)=>Text(values.pl1.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80,),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
                itemBuilder: (cxt, index) {
                  //final va=Provider.of<Values>(cxt,listen: false);
                  return GestureDetector(

                    onTap: () {
                      print(index);
                      _values.tapped(index,context);
                    },
                    child: Container(
                      color: Colors.yellow,
                      child: Center(
                        child: Consumer<Values>(
                          builder: (_, values, __) => Text(
                            values.value[index],
                            style: const TextStyle(
                                fontSize: 90, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
