import 'package:intl/intl.dart';

class Formatter {
  void parseDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  static String? parsePrice(double price) {
  if (price > 0) {
    // Convert price to integer part and decimal part
    String integerPart = price.truncate().toString();
    String decimalPart = (price - price.truncate()).toStringAsFixed(2).substring(1); // ".xx" format

    // Format integer part with commas
    RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
    String formattedInteger = integerPart.replaceAllMapped(regExp, (match) => ",");

    return "$formattedInteger$decimalPart";
  }
  return null;
}

  
}
