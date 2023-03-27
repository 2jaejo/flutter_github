import 'package:flutter/material.dart';
import '../comm/nw_comm.dart';

class PageHttp extends StatefulWidget {
  final String title;
  final String message;

  PageHttp({Key? key, this.title = "", this.message = ''}) : super(key: key);

  @override
  State<PageHttp> createState() => _PageHttpState();
}

class _PageHttpState extends State<PageHttp> {
  String title = '';
  String str = '';

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
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;
    if (args != null) {
      title = args['title'];
    }
    return GestureDetector(
      onTap: () {},
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(str),
              ElevatedButton(
                child: Text('get'),
                onPressed: () {
                  var res = Nw().fetchGet(
                      'http://118.67.130.229/systems/main/getTotalStat');
                  res.then((val) {
                    print(val);
                    setState(() {
                      str = val;
                    });
                  }).catchError((err) {
                    print('error');
                  });
                },
              ),
              ElevatedButton(
                child: Text('post'),
                onPressed: () {
                  print('1');

                  var res = Nw().fetchPost(
                    'http://118.67.130.229/getshipinfo',
                    {'company_no': '1231200000'},
                  );
                  res.then((val) {
                    print('3');
                    print(val);
                    setState(() {
                      str = val;
                    });
                  }).catchError((err) {
                    print('error');
                  });

                  print('2');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
