import 'package:flutter/material.dart';
import 'package:flutter_parrot/data/list_widget.dart';
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
        primaryColor: Color(0xFF49b046),
        accentColor: Color(0xFFfcee05),
        // scaffoldBackgroundColor: Color(0xff7de375)
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
  Widget _buildHero() {
    return Stack(
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 130),
                Text(
                  'Welcome to Flutter Parrot, the voice to widget search tool',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -100,
          right: 120,
          child: Image.asset('assets/logo.png'),
        ),
        Positioned(
          top: -40,
          right: 20,
          child: Row(
            children: <Widget>[
              Container(
                width: 30,
                child: Icon(
                  Icons.arrow_left,
                  size: 55,
                ),
              ),
              Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.black,
                          width: 1.5,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(35)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Try saying "Show me a Row Widget"'),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "assets/bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        appBar: AppBar(
          title: Text('Flutter Parrot'),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0), child: _buildHero())),
          ],
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
              ...widgetInfoList.map((w) {
                return ListTile(
                  title: Text(w.title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResultsPage(w.id)),
                    );
                  },
                );
              }).toList()
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: Icon(Icons.mic),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    ]);
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
