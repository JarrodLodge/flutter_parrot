import 'package:flutter_parrot/models/widget_info.dart';

List<WidgetInfo> widgetInfoList = [
  WidgetInfo(
      id: 1,
      title: 'Row',
      path: 'assets/widgetImage/row.png',
      webUrl: 'https://api.flutter.dev/flutter/widgets/Row-class.html',
      code:'''
```
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
```
  '''
  ),
  WidgetInfo(
      id: 2,
      title: 'Text',
      path: 'assets/widgetImage/text.jpg',
      webUrl: 'https://api.flutter.dev/flutter/widgets/Text-class.html',
      code:'''
```
String _name = 'Billy Bob';
Text(
  'Hello, \$_name! How are you?',
  textAlign: TextAlign.center,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(fontWeight: FontWeight.bold),
)
```
      '''
  ),
];

