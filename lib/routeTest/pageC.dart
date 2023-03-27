import 'package:flutter/material.dart';
import '../comm/nw_comm.dart';

class PageC extends StatelessWidget {
  final String title;
  final String message;
  final String url = 'assets/images/dog.jpg';

  const PageC({Key? key, required this.title, this.message = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Nw().assetImage(url, width: 100.0, height: 100.0),
            SizedBox(child: Text(message)),
            ElevatedButton(
              child: Text('Go back! A'),
              onPressed: () {
                // 현재 페이지를 스택에서 제거함으로써 이전으로 되돌아 갑니다.
                // Navigator.pop(context);

                // 모든 스택 제거후 첫 번째 페이지로 이동
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
