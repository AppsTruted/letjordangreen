import 'dart:ui';

String? getCountryCode() {
  return PlatformDispatcher.instance.locale.countryCode;
}