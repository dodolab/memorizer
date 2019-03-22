
class LocString {
  static const String DEFAULT_LOCALE = "la";
  final Map<String, String> locStrings;

  String getString(String locale, {String defaultLocale = DEFAULT_LOCALE}) {
    return locStrings.containsKey(locale) ? locStrings[locale] : locStrings[DEFAULT_LOCALE];
  }

  LocString.fromJSON(Map<String, dynamic> json)
      : locStrings = json.map((str, dyn) => MapEntry<String, String>(str, dyn));
}