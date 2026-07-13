import"package:flutter/material.dart";
import 'package:intl/intl.dart';
String getMaskedId(String fullId) {
  if (fullId.length < 4) return fullId;
  String last4 = fullId.substring(fullId.length - 4);
  return "**** **** **** $last4";
}

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  return Color(int.parse("FF$hexColor", radix: 16));
}

String toComma(dynamic number) {
  // Convert to double safely
  final value = _toDouble(number);

  // Handle negative values
  if (value.isNegative) {
    return '-${NumberFormat.currency(
      decimalDigits: 2,
      symbol: '',
      locale: 'de_DE',
    ).format(value.abs())}';
  }

  return NumberFormat.currency(
    decimalDigits: 2,
    symbol: '',
    locale: 'de_DE',
  ).format(value);
}
double _toDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is String) {
    // Remove any existing formatting
    final cleanString = value.replaceAll(',', '').replaceAll(' ', '');
    return double.tryParse(cleanString) ?? 0.0;
  }
  if (value is int) return value.toDouble();
  if (value is double) return value;
  return 0.0;
}

class ExtractedIds {
  final String productId;
  final String qrCodeId;

  ExtractedIds({required this.productId, required this.qrCodeId});

  factory ExtractedIds.fromString(String combinedString) {
    List<String> parts = combinedString.split('/');
    return ExtractedIds(
      productId: parts.isNotEmpty ? parts[0] : '',
      qrCodeId: parts.length > 1 ? parts[1] : '',
    );
  }
}
Color darkenColor(Color color, double factor) {
  return Color.lerp(color, Colors.black, factor)!;
}