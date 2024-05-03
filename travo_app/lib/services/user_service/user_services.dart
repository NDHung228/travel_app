import 'package:travo_app/models/language_model.dart';

class UserServices {
  late String _language;
  String get language => _language;
  
  static String getLanguageFromCode(String languageCode) {
    String _language = '';

    for (var lang in languageModel) {
      if (lang.languageCode == languageCode) {
        _language = lang.language;
        break;
      }
    }

    return _language;
  }
}
