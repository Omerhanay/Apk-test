/// Normalizes text for forgiving local search in English and Turkish.
///
/// Dart's toLowerCase() is not locale-aware: it maps 'İ' to 'i̇' (with a
/// combining dot) and leaves 'ı' distinct from 'i', so "İSTANBUL" would not
/// match "istanbul". This folds all four Turkish i forms to 'i' and strips the
/// Turkish diacritics, so "poliçe", "POLİÇE" and "police" all match.
String foldForSearch(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    final ch = String.fromCharCode(rune);
    buffer.write(switch (ch) {
      'İ' || 'I' || 'ı' || 'i' => 'i',
      'Ç' || 'ç' => 'c',
      'Ğ' || 'ğ' => 'g',
      'Ö' || 'ö' => 'o',
      'Ş' || 'ş' => 's',
      'Ü' || 'ü' => 'u',
      '̇' => '', // combining dot above, left behind by some lowercasings
      _ => ch.toLowerCase(),
    });
  }
  return buffer.toString();
}

/// Splits a query into folded search terms.
List<String> searchTerms(String query) =>
    foldForSearch(query).split(RegExp(r'[^\p{L}\p{N}]+', unicode: true)).where((t) => t.isNotEmpty).toList();
