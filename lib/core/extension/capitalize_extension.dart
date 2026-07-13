import 'package:intl/intl.dart';

// extension StringExtension on String? {
//   String? capitalize() {
//     if (this == null || this!.isEmpty) {
//       return this; // Return null or empty string as is
//     }
//     return "${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}";
//   }
// }
//

extension StringCapExtension on String {
  String? capitalize() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  // Capitalize each word in a sentence
  String? capitalizeEachWord() {
    if (isEmpty) {
      return this;
    }

    // Split the string by spaces
    final words = split(' ');

    // Capitalize each word
    final capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return capitalizedWords;
  }

  // Handle special characters and multiple spaces
  String? toTitleCase() {
    if (isEmpty) {
      return this;
    }

    // Handle multiple spaces and trim
    final trimmedText = trim();
    if (trimmedText.isEmpty) return this;

    // Split by spaces and capitalize each word
    final words = trimmedText.split(RegExp(r'\s+'));
    final capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      // Handle words with apostrophes (e.g., "player's")
      if (word.contains("'")) {
        final parts = word.split("'");
        final capitalizedParts = parts.map((part) {
          if (part.isEmpty) return part;
          return part[0].toUpperCase() + part.substring(1).toLowerCase();
        }).join("'");
        return capitalizedParts;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return capitalizedWords;
  }

  // Capitalize each word but keep some words lowercase (like 'and', 'of', 'the')
  String toProperCase({List<String>? lowercaseWords}) {
    if (isEmpty) {
      return this;
    }

    final defaultLowercase = ['and', 'of', 'the', 'for', 'with', 'in', 'on', 'at', 'to'];
    final wordsToLower = lowercaseWords ?? defaultLowercase;

    final words = split(' ');
    final capitalizedWords = words.asMap().entries.map((entry) {
      final index = entry.key;
      final word = entry.value;

      if (word.isEmpty) return word;

      // Always capitalize first and last word
      if (index == 0 || index == words.length - 1) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }

      // Check if word should be lowercase
      final lowerWord = word.toLowerCase();
      if (wordsToLower.contains(lowerWord)) {
        return lowerWord;
      }

      // Capitalize other words
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return capitalizedWords;
  }
}
