import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Picker {
  //datepicker
  Future<String> showDate(BuildContext context, init, String format) async {
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
  Future<String> showTime(BuildContext context, init, String format) async {
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
}
