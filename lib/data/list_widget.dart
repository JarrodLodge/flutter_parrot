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
  WidgetInfo(
      id: 3,
      title: 'Column',
      path: 'assets/widgetImage/column.png',
      webUrl: 'https://api.flutter.dev/flutter/widgets/Column-class.html',
      code:'''
```
Column(
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
      id: 4,
      title: 'Stack',
      path: 'assets/widgetImage/stack.png',
      webUrl: 'https://api.flutter.dev/flutter/widgets/Stack-class.html',
      code:'''
```
Stack(
  children: <Widget>[
    // Max Size
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
      height: 300.0,
      width: 300.0,
    ),
    Container(
      color: Colors.pink,
      height: 150.0,
      width: 150.0,
    )
  ],
),
```
      '''
  ),
  WidgetInfo(
      id: 5,
      title: 'Spacer',
      path: '',
      webUrl: 'https://api.flutter.dev/flutter/widgets/Spacer-class.html',
      code:'''
```
Row(
  children: <Widget>[
    Text('Begin'),
    Spacer(), // Defaults to a flex of one.
    Text('Middle'),
    // Gives twice the space between Middle and End than Begin and Middle.
    Spacer(flex: 2),
    Text('End'),
  ],
)
```
      '''
  ),
];

