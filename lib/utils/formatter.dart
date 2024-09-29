import 'package:intl/intl.dart';

class Formatter{

  void parseDateTime(String dateString){
    DateTime dateTime = DateTime.parse(dateString);

  String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  
  }
  
}