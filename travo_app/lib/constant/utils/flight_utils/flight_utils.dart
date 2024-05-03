import 'package:intl/intl.dart';
import 'package:travo_app/constant/utils/image_constant.dart';

class FlightUtils {
  static String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  static String formatTime(String inputTime) {
    DateTime dateTime = DateTime.parse(inputTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  static String getImagePath(String airline) {
    switch (airline) {
      case 'AirAsia':
        return ImageConstant.AirAsia;
      case 'LionAir':
        return ImageConstant.LionAir;
      case 'BatikAir':
        return ImageConstant.BatikAir;
      case 'Garuna':
        return ImageConstant.Garuna;
      case 'Citilink':
        return ImageConstant.Citilink;
      default:
        return ImageConstant.flightsImg; // Default image for unknown airlines
    }
  }
}
