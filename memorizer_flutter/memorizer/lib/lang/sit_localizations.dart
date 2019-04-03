import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// We have to build this file before we uncomment the next import line,
// and we'll get to that shortly
import '../l10n/messages_all.dart';

class SitLocalizations {
  /// Initialize localization systems and messages
  static Future<SitLocalizations> load(Locale locale) async {
// If we're given "en_US", we'll use it as-is. If we're
// given "en", we extract it and use it.
    final String localeName =
        locale.countryCode == null || locale.countryCode.isEmpty
            ? locale.languageCode
            : locale.toString();

// We make sure the locale name is in the right format e.g.
// converting "en-US" to "en_US".
    final String canonicalLocaleName = Intl.canonicalizedLocale(localeName);

// Load localized messages for the current locale.
  await initializeMessages(canonicalLocaleName);
// We'll uncomment the above line after we've built our messages file

// Force the locale in Intl.
    Intl.defaultLocale = canonicalLocaleName;

    return SitLocalizations();
  }

  /// Retrieve localization resources for the widget tree
  /// corresponding to the given `context`
  static SitLocalizations of(BuildContext context) =>
      Localizations.of<SitLocalizations>(context, SitLocalizations);

  // Localized Messages
  String get app_name => Intl.message('app_name');
  String get categories => Intl.message('categories');
  String get gallery => Intl.message('gallery');
  String get memorizer => Intl.message('memorizer');
  String get practice => Intl.message('practice');
  String get select => Intl.message('select');
  String get start => Intl.message('start');
  String get lang_cs => Intl.message('lang_cs');
  String get lang_en => Intl.message('lang_en');
  String get lang_la => Intl.message('lang_la');
  String get select_language => Intl.message('select_language');
  String get summary => Intl.message('summary');
  String get error_entities => Intl.message('error_entities');
  String get answer_yes => Intl.message('answer_yes');
  String get answer_no => Intl.message('answer_no');
  String get exitdialog_title => Intl.message('exitdialog_title');
  String get exitdialog_message => Intl.message('exitdialog_message');
}
