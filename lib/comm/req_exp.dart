class ReqExp {
  bool isValidPhoneNumberFormat(str) {
    return RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$').hasMatch(str);
  }

  Future<String> addComma(String num) async {
    if (num == '') return '';

    var regexp = RegExp(r'/B(?=(d{3})+(?!d))');
    return num.toString().replaceAll(regexp, ',');
  }

  String addColon(String num) {
    if (num == '') return '';

    var regexp = RegExp(r'/B(?=(d{2})+(?!d))');
    return num.toString().replaceAll(regexp, ':');
  }

  String addTel(String num) {
    if (num == '') return '';

    var regexp =
        RegExp(r'/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/');
    return num.toString()
        .replaceAll(regexp, "${1}-${2}-${3}")
        .replaceAll("--", "-");
  }
}
