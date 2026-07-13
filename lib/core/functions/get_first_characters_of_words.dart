String getFirstCharactersOfWords(String sentence) {
  List<String> words = sentence.split(' ');

  try{
    if (words.length > 1) {
      String firstWord = words[0];
      String firstCharacterFirstWord = firstWord[0];

      String secondWord = words[1];
      String firstCharacterSecondWord = secondWord[0];

      String result = '$firstCharacterFirstWord$firstCharacterSecondWord';

      return result.toUpperCase();
    } else {
      return sentence[0].toUpperCase();
    }
  } catch (_){

    return sentence.isNotEmpty? sentence[0].toUpperCase() : "";

  }
}