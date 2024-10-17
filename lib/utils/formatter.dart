import 'package:intl/intl.dart';

class Formatter {

  static String parsePrice(double price, {bool asInt = false}) {
    if (price > 0) {
      if (asInt == false) {
        // Convert price to integer part and decimal part
        String integerPart = price.truncate().toString();
        String decimalPart = (price - price.truncate()).toStringAsFixed(2).substring(1); // ".xx" format

        // Format integer part with commas
        RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
        String formattedInteger = integerPart.replaceAllMapped(regExp, (match) => ",");

        return "$formattedInteger$decimalPart";
      } else if (asInt == true) {
        String integerPart = price.truncate().toString();
        // Format integer part with commas
        RegExp regExp = RegExp(r'\B(?=(\d{3})+(?!\d))');
        String formattedInteger = integerPart.replaceAllMapped(regExp, (match) => ",");
        return formattedInteger;
      }
    }
    return "0";
  }

  static String timeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 1) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays == 1) {
    return '1 day ago';
  } else if (difference.inHours > 1) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours == 1) {
    return '1 hour ago';
  } else if (difference.inMinutes > 1) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inMinutes == 1) {
    return '1 minute ago';
  } else {
    return 'just now';
  }
}

}
