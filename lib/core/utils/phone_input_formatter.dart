import 'package:flutter/services.dart';

class InternationalPhoneFormatter extends TextInputFormatter {
  String internationalPhoneFormat(value) {
    // ignore: avoid_dynamic_calls
    final String nums = value.replaceAll(RegExp(r'[\D]'), '');
    final String internationalPhoneFormatted = nums.isNotEmpty
        ? '+${nums.substring(0, nums.isNotEmpty ? 1 : null)}${nums.length > 1 ? ' (' : ''}${nums.substring(1, nums.length >= 4 ? 4 : null)}${nums.length > 4 ? ') ' : ''}${nums.length > 4 ? nums.substring(4, nums.length >= 7 ? 7 : null) + (nums.length > 7 ? '-${nums.substring(7, nums.length >= 11 ? 11 : null)}' : '') : ''}'
        : nums;
    return internationalPhoneFormatted;
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    return newValue.copyWith(
      text: internationalPhoneFormat(text),
      selection: TextSelection.collapsed(offset: internationalPhoneFormat(text).length),
    );
  }
}
