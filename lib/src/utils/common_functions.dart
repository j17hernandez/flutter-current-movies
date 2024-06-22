import 'dart:async';

import 'package:CurrentMovies/src/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonFunctions {
  static void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.$colorTertiary,
        content: Text('El texto se ha copiado al portapapeles.',
            style: TextStyle(fontSize: 20)),
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  static String formatAsMoney(String amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 0,
    );
    if (amount.isEmpty) {
      return '';
    }
    return formatter.format(double.parse(amount));
  }

  static void clearPreferences() {
    final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      value.remove("dataUser");
    });
  }
}
