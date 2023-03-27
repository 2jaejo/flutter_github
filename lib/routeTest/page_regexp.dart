import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../comm/nw_comm.dart';

class PageRegexp extends StatefulWidget {
  final String title;
  final String message;

  PageRegexp({Key? key, this.title = "", this.message = ''}) : super(key: key);

  @override
  State<PageRegexp> createState() => _PageRegexpState();
}

class _PageRegexpState extends State<PageRegexp> {
  String title = '';

  var aCtrl = TextEditingController();
  var bCtrl = TextEditingController();
  var cCtrl = TextEditingController();
  var dCtrl = TextEditingController();

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
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: aCtrl,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                    NwFormatter(type: 'comma'),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'comma',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  onChanged: (ev) {
                    print(ev);
                  },
                ),
                TextFormField(
                  controller: bCtrl,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                    NwFormatter(type: 'tel'),
                  ],
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'tel',
                    prefixIcon: Icon(Icons.phone_iphone),
                  ),
                  onChanged: (ev) {
                    print(ev);
                  },
                ),
                TextFormField(
                  controller: cCtrl,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                    NwFormatter(type: 'date'),
                  ],
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'date',
                    prefixIcon: Icon(Icons.calendar_month),
                  ),
                  onChanged: (ev) {
                    print(ev);
                  },
                ),
                TextFormField(
                  controller: dCtrl,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    NwFormatter(type: 'time'),
                  ],
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'time',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  onChanged: (ev) {
                    print(ev);
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
