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
  String get title => Intl.message('memorizer');
  String get categories => Intl.message('categories');
  String get practice => Intl.message('practice');
  String get gallery => Intl.message('gallery');
  String get start => Intl.message('start');
  String get select => Intl.message('select');
}
