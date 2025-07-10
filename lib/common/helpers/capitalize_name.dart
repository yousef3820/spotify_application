extension StringCasingExtension on String {
  String capitalizeEachWord() {
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return '${word[0].toUpperCase()}${word.substring(1)}';
    }).join(' ');
  }
}