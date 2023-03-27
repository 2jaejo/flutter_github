import 'package:flutter/material.dart';

class NwDropdown {
  setDropdown(sel_list, sel_value, change) {
    return DropdownButton<String>(
      isExpanded: true,
      value: sel_value,
      icon: const Icon(Icons.expand_more),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: change,
      items: sel_list.map<DropdownMenuItem<String>>((i) {
        return DropdownMenuItem<String>(
          value: i['value'],
          child: Text(i['text']),
        );
      }).toList(),
    );
  }
}
