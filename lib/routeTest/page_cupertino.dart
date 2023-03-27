import 'package:flutter/material.dart';
import '../comm/nw_comm.dart';

class Data {
  final String value;
  final String text;

  Data(this.value, this.text);
}

class PageCupertino extends StatefulWidget {
  PageCupertino({Key? key}) : super(key: key);

  @override
  State<PageCupertino> createState() => _PageCupertinoState();
}

class _PageCupertinoState extends State<PageCupertino> {
  String title = '';

  var aCtrl = TextEditingController();
  var bCtrl = TextEditingController();
  var cCtrl = TextEditingController();

  final List _list = [
    Data('ap', 'Apple'),
    Data('ma', 'Mango'),
    Data('ba', 'Banana'),
    Data('or', 'Orange'),
    Data('pi', 'Pineapple'),
    Data('st', 'Strawberry'),
  ];

  var sel_list = <Map<String, dynamic>>[
    {"value": '1', "text": 'One'},
    {"value": '2', "text": 'Two'},
    {"value": '3', "text": 'Three'},
    {"value": '4', "text": 'Four'},
    {"value": '5', "text": 'Five'},
  ];
  var _selected;

  @override
  void initState() {
    _selected = sel_list[0]['value'];

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
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'cupertino date picker',
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                  onTap: () {
                    Nw().showDateDialog(
                      context,
                      (dt) {
                        var date =
                            '${dt.year.toString()}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
                        aCtrl.text = date;
                        print(date);
                      },
                      DateTime.now(),
                    );
                  },
                ),
                TextFormField(
                  controller: bCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'cupertino time picker',
                    suffixIcon: Icon(Icons.schedule),
                  ),
                  onTap: () {
                    Nw().showTimeDialog(
                      context,
                      (dt) {
                        var time =
                            '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                        bCtrl.text = time;
                        print(time);
                      },
                      DateTime.now(),
                    );
                  },
                ),
                TextFormField(
                  controller: cCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'cupertino picker',
                    suffixIcon: Icon(Icons.expand_more),
                  ),
                  onTap: () {
                    Nw().showListDialog(
                      context,
                      (i) {
                        print(_list[i].value);
                        print(_list[i].text);
                        cCtrl.text = _list[i].text;
                      },
                      _list,
                      0,
                    );
                  },
                ),
                Nw().setDropDown(
                  'test',
                  sel_list,
                  _selected,
                  (ev) {
                    setState(() {
                      _selected = ev;
                    });
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
