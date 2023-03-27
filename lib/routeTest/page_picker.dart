import 'package:flutter/material.dart';
import '../comm/nw_comm.dart';

class PagePicker extends StatefulWidget {
  PagePicker({Key? key}) : super(key: key);

  @override
  State<PagePicker> createState() => _PagePickerState();
}

class _PagePickerState extends State<PagePicker> {
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
                    labelText: 'date picker',
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                  onTap: () async {
                    var dt = await Nw().showDate(context, DateTime.now(), '-');
                    aCtrl.text = dt;
                    print(dt);
                  },
                ),
                TextFormField(
                  controller: bCtrl,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'time picker',
                    suffixIcon: Icon(Icons.schedule),
                  ),
                  onTap: () async {
                    var tm = await Nw().showTime(context, TimeOfDay.now(), ':');
                    bCtrl.text = tm;
                    print(tm);
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
