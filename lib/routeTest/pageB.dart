import 'package:flutter/material.dart';
import '../comm/nw_comm.dart';

class PageB extends StatefulWidget {
  const PageB({super.key});

  @override
  State<PageB> createState() => _PageBState();
}

class _PageBState extends State<PageB> {
  String title = 'default title';
  String message = 'default message';

  final String url =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIVFIngWVOJLyCmHePABcoMTqqATnNHkiVSA&usqp=CAU';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;
    if (args != null) {
      title = args['title'];
      message = args['message'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Nw().networkImage(url),
            Text(message),
            ElevatedButton(
              child: Text('Launch C'),
              onPressed: () {
                // 클릭하면 세 번째 화면으로 전환합니다!
                Navigator.pushNamed(context, '/c');
              },
            ),
          ],
        ),
      ),
    );
  }
}
