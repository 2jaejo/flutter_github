import 'package:flutter/material.dart';

class Data {
  final String value;
  final String text;

  Data(this.value, this.text);
}

class PageA extends StatefulWidget {
  final String title;
  final String message;

  PageA({Key? key, this.title = "", this.message = ''}) : super(key: key);

  @override
  State<PageA> createState() => _PageAState();
}

class _PageAState extends State<PageA> {
  OverlayEntry? overlayEntry;
  final LayerLink _Link = LayerLink();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CompositedTransformTarget(
                  link: _Link,
                  child: Text('overlay'),
                ),
                Text(widget.message),
                ElevatedButton(
                  child: Text('Launch B'),
                  onPressed: () {
                    Map data = {
                      'title': 'args title Test',
                      'message': 'args message Test',
                    };
                    // 클릭하면 두 번째 화면으로 전환합니다!
                    Navigator.pushNamed(context, '/b', arguments: data);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
