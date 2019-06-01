import 'package:flutter_parrot/models/widget_info.dart';

List<WidgetInfo> widgetInfoList = [
  WidgetInfo(
      id: 1,
      title: 'Row',
      path: 'path/to/image',
      code:'''
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
  '''
  ),
  WidgetInfo(
      id: 2,
      title: 'Text',
      path: '',
      code:'''
Text(
  'Hello, \$_name! How are you?',
  textAlign: TextAlign.center,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(fontWeight: FontWeight.bold),
)
      '''
  ),
];

