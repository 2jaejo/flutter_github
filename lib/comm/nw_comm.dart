import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Nw {
  //post
  Future<String> fetchPost(url, Map<String, dynamic> map) async {
    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(map));

    return response.body;
  }

  //get
  Future<String> fetchGet(url) async {
    final response = await http
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    return response.body;
  }

  //alert
  Future<void> showAlert(BuildContext context, dynamic text) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(text),
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
  void showConfirm(BuildContext context, dynamic text, Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(text),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              callback(text);
              Navigator.pop(context);
            },
            child: const Text('확인'),
          )
        ],
      ),
    );
  }

  //asset image
  Widget assetImage(url, {double width = 100.0, double height = 100.0}) {
    return Image.asset(
      url,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          width: width,
          height: height,
          child: Image.asset('assets/images/no_image.png', fit: BoxFit.cover),
        );
      },
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  //network image
  Widget networkImage(url, {double width = 100.0, double height = 100.0}) {
    return Image.network(
      url,
      frameBuilder: (BuildContext context, Widget child, int? frame,
          bool? wasSynchronouslyLoaded) {
        return child;
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return Center(child: child);
        }
        return Center(
          child: CircularProgressIndicator(
            value: (loadingProgress.expectedTotalBytes != null)
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Center(child: Text('이미지 준비중..'));
      },
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  //datepicker
  Future<String> showDate(
      BuildContext context, DateTime init, String format) async {
    var init_dt = init;
    var min_dt = DateTime(init.year - 10, init.month, init.day);
    var max_dt = DateTime(init.year + 10, init.month, init.day);

    final DateTime? selected = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: init_dt,
      firstDate: min_dt,
      lastDate: max_dt,
    );

    var str = selected!.year.toString() +
        format +
        selected.month.toString().padLeft(2, '0') +
        format +
        selected.day.toString().padLeft(2, '0');

    HapticFeedback.lightImpact();
    return str;
  }

  //timepicker
  Future<String> showTime(
      BuildContext context, TimeOfDay init, String format) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: init,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
              // Using 12-Hour format
              alwaysUse24HourFormat: true),
          // If you want 24-Hour format, just change alwaysUse24HourFormat to true
          child: child!,
        );
      },
    );

    var str = selected!.hour.toString().padLeft(2, '0') +
        format +
        selected.minute.toString().padLeft(2, '0');

    HapticFeedback.lightImpact();
    return str;
  }

  //Date picker
  void showDateDialog(BuildContext context, callback, DateTime init,
      {int term = 10}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 6.0),
        // The bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            dateOrder: DatePickerDateOrder.ymd,
            use24hFormat: true,
            showDayOfWeek: false,
            minuteInterval: 1,
            initialDateTime: init,
            minimumYear: init.year - term,
            maximumYear: init.year + term,
            onDateTimeChanged: (ev) {
              HapticFeedback.lightImpact();
              callback(ev);
            },
          ),
        ),
      ),
    );
  }

  //Time picker
  void showTimeDialog(context, callback, DateTime init) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 6.0),
        // The bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: init,
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            // This is called when the user changes the date.
            onDateTimeChanged: (ev) {
              HapticFeedback.lightImpact();
              callback(ev);
            },
          ),
        ),
      ),
    );
  }

  //List picker
  void showListDialog(BuildContext context, callback, List item, int init) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => SizedBox(
        height: 200.0,
        width: double.infinity,
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            itemExtent: 32.0,
            backgroundColor: Colors.white,
            scrollController: FixedExtentScrollController(initialItem: init),
            onSelectedItemChanged: (ev) {
              HapticFeedback.lightImpact();
              callback(ev);
            },
            children: List<Widget>.generate(item.length, (int index) {
              return Center(
                child: Text(item[index].text),
              );
            }),
          ),
        ),
      ),
    );
  }

  setDropDown(String label, List sel_list, String sel_value, change) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: sel_value,
      icon: Visibility(visible: false, child: Icon(Icons.expand_more)),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Icon(Icons.expand_more),
      ),
      // icon: const Icon(Icons.expand_more),
      // style: const TextStyle(color: Colors.blue),

      onChanged: change,
      items: sel_list.map<DropdownMenuItem<String>>((i) {
        return DropdownMenuItem<String>(
          value: i['value'],
          child: Text(i['text']),
        );
      }).toList(),
    );
  }

  //number format
  String addComma(String num) {
    if (num == '') return '';
    var str = num.replaceAll(',', '');

    // var regexp = RegExp(r'B(?=(d{3})+(?!d))');
    // return num.toString().replaceAll(regexp, ',');

    return NumberFormat('#,###').format(int.parse(num));
  }

  //tel format
  String addTel(String num) {
    if (num == '') return '';

    var regexp =
        RegExp(r'(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})');
    return num.toString()
        .replaceAll(regexp, "${1}-${2}-${3}")
        .replaceAll("--", "-");
  }

//
}

class NwFormatter extends TextInputFormatter {
  var type;

  NwFormatter({Key? key, required this.type});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text == oldValue.text) {
      return newValue;
    } else {
      String formatted;
      final selectionIndex;
      switch (type) {
        case 'comma':
          formatted = newValue.text.replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (match) => '${match.group(1)},',
          );
          selectionIndex = formatted.length -
              (formatted.replaceAll(',', '').length - newValue.selection.end);
          break;

        case 'tel':
          formatted = newValue.text
              .replaceAllMapped(
                  RegExp(
                      r'(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})'),
                  (m) => '${m[1]}-${m[2]}-${m[3]}')
              .replaceAll("null", "")
              .replaceAll("--", "-");
          selectionIndex = formatted.length -
              (formatted.replaceAll('-', '').length - newValue.selection.end);

        case 'date':
          formatted = newValue.text.replaceAllMapped(
              RegExp(r'(^\d{4})(\d{2})(\d{2})'),
              (m) => '${m[1]}-${m[2]}-${m[3]}');
          selectionIndex = formatted.length -
              (formatted.replaceAll('-', '').length - newValue.selection.end);

        case 'time':
          formatted = newValue.text.replaceAllMapped(
              RegExp(r'(^\d{2})(\d{2})'), (m) => '${m[1]}:${m[2]}');
          selectionIndex = formatted.length -
              (formatted.replaceAll(':', '').length - newValue.selection.end);

        default:
          formatted = newValue.text;
          selectionIndex = newValue.selection.end;
          break;
      }

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: selectionIndex),
      );
    }
  }
}
