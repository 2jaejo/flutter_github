import 'package:flutter/material.dart';
import '../comm/nw_comm.dart';

class PageImage extends StatefulWidget {
  final String title;
  final String message;

  PageImage({Key? key, this.title = "", this.message = ''}) : super(key: key);

  @override
  State<PageImage> createState() => _PageImageState();
}

class _PageImageState extends State<PageImage> {
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
              Text('asset Image'),
              Nw().assetImage('assets/images/dog.jpg'),
              SizedBox(height: 20),
              Text('network Image'),
              Nw().networkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIVFIngWVOJLyCmHePABcoMTqqATnNHkiVSA&usqp=CAU'),
            ],
          ),
        ),
      ),
    );
  }
}
