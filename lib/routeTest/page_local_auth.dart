import 'package:flutter/material.dart';
import '../comm/nw_auth.dart';

class PageLocalAuth extends StatefulWidget {
  final String title;
  final String message;

  PageLocalAuth({Key? key, this.title = "", this.message = ''})
      : super(key: key);

  @override
  State<PageLocalAuth> createState() => _PageLocalAuthState();
}

class _PageLocalAuthState extends State<PageLocalAuth> {
  String title = '';

  var aCtrl = TextEditingController();
  var bCtrl = TextEditingController();

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
        body: Center(child: NwAuth()),
      ),
    );
  }
}
