import 'package:flutter/material.dart';
import 'package:flutter_parrot/models/widget_info.dart';
import 'package:flutter_parrot/pages/results.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Parrot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WidgetInfo> _widgetInfoList = [
    WidgetInfo(
      id: 1,
      title: 'Row',
      path: '',
      code: ''
    ),
    WidgetInfo(
      id: 2,
      title: 'Column',
      path: '',
      code: ''
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Parrot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome to Flutter Parrot, the voice to widget search tool',
                      style: TextStyle(fontSize: 25),
                    ),
                  )),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ..._widgetInfoList.map((w) {
              return ListTile(
              title: Text(w.title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultsPage(w.id)),
                );
              },
            );
            }).toList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        tooltip: 'Increment',
        child: Icon(Icons.mic),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
