import 'package:intl/intl.dart';

class Formatter {
  void parseDateTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);
  }

  String? parsePrice(double price) {
    if (price > 0) {
      final double priceToPrecisionTwo = (price - price.round()).abs();
      final String priceToFixedTwo = priceToPrecisionTwo.toStringAsFixed(2);
      final String outputPriceDecimal = ".${priceToFixedTwo[priceToFixedTwo.length - 2]}${priceToFixedTwo[priceToFixedTwo.length - 1]}";

      final String outputPrice = price.truncate().toString();
      String finalOutputPrice = "";

      for(int i = outputPrice.length; i >= 0; i-3){
        if(i - 3 > 0){
          finalOutputPrice = "${outputPrice[i-3]}${outputPrice[i-2]}${outputPrice[i-1]},$finalOutputPrice";
        }else{
          if(i == 3){
            finalOutputPrice = "${outputPrice[0]}${outputPrice[1]}${outputPrice[2]},$finalOutputPrice";
          }else if(i == 2){
            finalOutputPrice = "${outputPrice[0]}${outputPrice[1]},$finalOutputPrice";
          }else if(i == 1){
            finalOutputPrice = "${outputPrice[0]},$finalOutputPrice";
          }
        }

      }

      return "$finalOutputPrice$outputPriceDecimal";
    }
    return null;
  }
}
