import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CuperPicker {
  // const CuperPicker({Key? key}) : super(key: key);

  //Date picker
  void showDateDialog(BuildContext context, callback, init, {term = 10}) {
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
  void showTimeDialog(context, callback, init) {
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
  void showListDialog(BuildContext context, callback, item, init) {
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
}
