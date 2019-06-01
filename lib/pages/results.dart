import 'package:flutter/material.dart';
import 'package:flutter_parrot/models/widget_info.dart';

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

  WidgetInfo result;

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
      body: Text(result.title),
    );
  }
}