import 'package:flutter/material.dart';
import 'package:flutter_parrot/models/widget_info.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_parrot/data/list_widget.dart';

class ResultsPage extends StatefulWidget {
  final int id;
  ResultsPage(this.id);
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  WidgetInfo result;

  WebViewController _controller;

  @override
  void initState() {
    result = widgetInfoList.firstWhere((w) => w.id == widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(result.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            result.path != ''
                ? SizedBox(height: 250, child: Image.asset(result.path))
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: MarkdownBody(data: result.code),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 1000,
                child: WebView(
                  initialUrl:
                      result.webUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                    // _controller.loadUrl('http://www.google.com');
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //
}
