import 'package:flutter/material.dart';
import '../comm/nw_comm.dart';

class PageAlert extends StatefulWidget {
  final String title;
  final String message;

  PageAlert({Key? key, this.title = "", this.message = ''}) : super(key: key);

  @override
  State<PageAlert> createState() => _PageAlertState();
}

class _PageAlertState extends State<PageAlert> {
  String title = '';

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
              ElevatedButton(
                child: Text('alert'),
                onPressed: () {
                  Nw().showAlert(context, 'alert');
                },
              ),
              ElevatedButton(
                child: Text('confirm'),
                onPressed: () {
                  Nw().showConfirm(
                    context,
                    'confirm',
                    (ev) {
                      print(ev);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
