import 'dart:convert';

import 'package:flutter/material.dart';
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
  final SpeechRecognition _speech = SpeechRecognition();
  bool _speechRecognitionAvailable = false;
  String _currentLocale;
  String transcription;
  bool _isListening = false;
  final String endpoint = 'https://us-central1-hack19-akl.cloudfunctions.net/getSearchKeywords';

  void showParrotSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(message)));
  }
  
  @override
  void initState() {
    super.initState();
    // The flutter app not only call methods on the host platform,
    // it also needs to receive method calls from host.
    _speech.setAvailabilityHandler((bool result)
      => setState(() => _speechRecognitionAvailable = result));

    // handle device current locale detection
    _speech.setCurrentLocaleHandler((String locale) =>
    setState(() => _currentLocale = locale));

    _speech.setRecognitionStartedHandler(() => setState(() => _isListening = true));
    _speech.setRecognitionResultHandler((String text) => setState(() => transcription = text));
    _speech.setRecognitionCompleteHandler(() => setState(() => _isListening = false));

    _speech
    .activate()
    .then((res) => setState(() => _speechRecognitionAvailable = res));
  }

  Widget _voiceButton() {
    final double boxWidth = 65;
    return Positioned(
      bottom: 20.0,
      left: MediaQuery.of(context).size.width/2 - boxWidth/2,
      child: GestureDetector(
        onLongPress: () {
          _speech.listen(locale:_currentLocale).then((result)=> print('result : $result'));
        },
        onLongPressUp: () {
          _speech.stop();
          _callApi(transcription);
        },
        child: Container(
          width: boxWidth,
          height: boxWidth,
          decoration: BoxDecoration(
            color: _isListening ? Colors.redAccent : Theme.of(context).accentColor,
            shape: BoxShape.circle
          ),
          child: Center(
            child: Icon(
              Icons.mic,
              color: Colors.white,
              size: 30.0,
            )
          )
        ),
      ),
    );
  }

  _callApi(String searchText) async {
    var response = await http.post(endpoint, body: {'sentence': searchText});
    if (response.statusCode == 200) {
      NlpResponse nlpResponse = NlpResponse.fromJson(jsonDecode(response.body));
      if (nlpResponse.response.length == 0) {
        // show snackbar TODO
      } else {
        final NlpResponseItem item = nlpResponse.response[0];
      }
    } else {
      // show snapview TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Parrot'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Center(
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
                ),
              ],
            ),
          ),
          _voiceButton()
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
    );
  }
}
