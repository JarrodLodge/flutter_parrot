import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_parrot/data/list_widget.dart';
import 'package:flutter_parrot/models/nlp_response.dart';
import 'package:flutter_parrot/models/widget_info.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_parrot/pages/results.dart';
import 'package:speech_recognition/speech_recognition.dart';

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
          height: 250,
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
        )
      ],
    );
  }

  final SpeechRecognition _speech = SpeechRecognition();
  bool _speechRecognitionAvailable = false;
  String _currentLocale;
  String transcription;
  bool _isListening = false;
  final String endpoint =
      'https://us-central1-hack19-akl.cloudfunctions.net/getSearchKeywords';

  void showParrotSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(message)));
  }

  @override
  void initState() {
    super.initState();
    // The flutter app not only call methods on the host platform,
    // it also needs to receive method calls from host.
    _speech.setAvailabilityHandler(
        (bool result) => setState(() => _speechRecognitionAvailable = result));

    // handle device current locale detection
    _speech.setCurrentLocaleHandler(
        (String locale) => setState(() => _currentLocale = locale));

    _speech.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));
    _speech.setRecognitionResultHandler(
        (String text) => setState(() => transcription = text));
    _speech.setRecognitionCompleteHandler(
        () => setState(() => _isListening = false));

    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  Widget _voiceButton(BuildContext context) {
    final double boxWidth = 65;
    return Positioned(
      bottom: 50.0,
      left: MediaQuery.of(context).size.width / 2 - boxWidth / 2,
      child: GestureDetector(
        onLongPress: () {
          _speech
              .listen(locale: _currentLocale)
              .then((result) => print('result : $result'));
        },
        onLongPressUp: () {
          _speech.cancel();
          _speech.stop();
          print('onLongPressUp');
          _callApi(transcription, context);
        },
        child: Container(
            width: boxWidth,
            height: boxWidth,
            decoration: BoxDecoration(
                color: _isListening
                    ? Colors.redAccent
                    : Theme.of(context).accentColor,
                shape: BoxShape.circle),
            child: Center(
                child: Icon(
              Icons.mic,
              color: Colors.grey,
              size: 30.0,
            ))),
      ),
    );
  }

  _callApi(String searchText, BuildContext context) async {
    var response = await http.post(endpoint, body: {'sentence': searchText});
    if (response.statusCode == 200) {
      NlpResponse nlpResponse = NlpResponse.fromJson(jsonDecode(response.body));
      if (nlpResponse.response.length == 0) {
        print('0');
        showParrotSnackBar(context, 'Oops; try Column, Text Row or Stack');
      } else {
        final NlpResponseItem item = nlpResponse.response[0];
        print(item.keyword);
        widgetInfoList.forEach((widgetItem) {
          if (widgetItem.title.toLowerCase() == item.keyword.toLowerCase()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultsPage(widgetItem.id)),
            );
          } else {
            showParrotSnackBar(context, 'Oops; try Column, Text Row or Stack');
          }
        });
      }
    } else {
      print('1');
      showParrotSnackBar(context, 'Oops; try column text row or stack');
    }
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
        body: Stack(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0), child: _buildHero()),
            ),
            Builder(builder:(context) {
              return _voiceButton(context);
            }              
            ),
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
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    ]);
  }
}
