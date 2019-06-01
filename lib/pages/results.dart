import 'package:flutter/material.dart';
import 'package:flutter_parrot/models/widget_info.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ResultsPage extends StatefulWidget {
  final int id;
  ResultsPage(this.id);
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<WidgetInfo> _widgetInfoList = [
    WidgetInfo(
      id: 1,
      title: 'Row',
      path: 'path/to/image',
      code: 'Row\n(children: [\nContainer(\ncolor: Colors.orange,\nchild: FlutterLogo(\nsize: 60.0,\n),\n),\nContainer(\ncolor: Colors.blue,\nchild: FlutterLogo(\nsize: 60.0,\n),\n),\nContainer(\ncolor: Colors.purple,\nchild: FlutterLogo(\nsize: 60.0,\n),\n),\n],\n)'
    ),
    WidgetInfo(
      id: 2,
      title: 'Text',
      path: '',
      code: 'Text(\'Hello, \$_name! How are you?\', textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),)'
    ),
  ];

  WidgetInfo result;

  String testString = '''
Row(
  children: [
    Container(
      color: Colors.orange,
      child: FlutterLogo(
        size: 60.0,
      ),
    ),
    Container(
      color: Colors.blue,
      child: FlutterLogo(
        size: 60.0,
      ),
    ),
    Container(
      color: Colors.purple,
      child: FlutterLogo(
        size: 60.0,
      ),
    ),
  ],
)

  ''';

  @override
  void initState() {
    result = _widgetInfoList.firstWhere((w) => w.id == widget.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(result.title),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 250,
            child: Image.asset('assets/widgetImage/row.png')),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MarkdownBody(data: testString),
            ))
        ],
      ),
    );
  }

  // 
}