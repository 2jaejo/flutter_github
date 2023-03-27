import 'package:flutter/material.dart';

class Alert {
  // const Alert({Key? key}) : super(key: key);

  //alert
  Future<void> showAlert(BuildContext context, dynamic val) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(val),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('확인'),
          )
        ],
      ),
    );
  }

  //confirm
  void showConfirm(BuildContext context, dynamic val, Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(val),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              callback(val);
              Navigator.pop(context);
            },
            child: const Text('확인'),
          )
        ],
      ),
    );
  }
}
