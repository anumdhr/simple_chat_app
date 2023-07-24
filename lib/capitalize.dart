class Capitalize {
  static String  capitalizeFirstOfEach(String sentence) {
    if (sentence.isNotEmpty) {
      var words = sentence.split(' ');
      var capitalizedWords =
      words.map((word) => word.substring(0, 1).toUpperCase() + word.substring(1));
      return capitalizedWords.join(' ');
    } else {
      return '';
    }
  }
  static String capitalizeSentences(String input) {
    if (input.isEmpty) return '';
    // Split the input into sentences by '. '
    List<String> sentences = input.split('. ');
    // Capitalize the first letter of each sentence
    sentences = sentences.map((sentence) {
      if (sentence.isNotEmpty) {
        return sentence[0].toUpperCase() + sentence.substring(1);
      }
      return sentence;
    }).toList();
    // Join the sentences back together with '. ' separator
    return sentences.join('. ');
  }
}