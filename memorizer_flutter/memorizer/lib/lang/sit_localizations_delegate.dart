import 'dart:async';

import 'package:flutter/material.dart';

import 'sit_localizations.dart';

class SitLocalizationsDelegate extends LocalizationsDelegate<SitLocalizations> {
  const SitLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<SitLocalizations> load(Locale locale) => SitLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<SitLocalizations> old) => false;
}