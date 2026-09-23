import '../text/search_fold.dart';

/// Document types LIFE OS understands. Shared with the relay's extractor.
const documentTypes = [
  'insurance', 'vehicle_registration', 'passport', 'id_card', 'driver_license', 'warranty',
  'invoice', 'receipt', 'contract', 'travel', 'medical', 'other',
];

/// Types whose content never goes to the AI relay: identity documents and
/// health records. They are classified and read on the device only.
const localOnlyDocumentTypes = {'passport', 'id_card', 'driver_license', 'medical'};

/// Days before an expiry date to remind, per type.
const reminderLeadDays = {
  'insurance': 30,
  'vehicle_registration': 30,
  'passport': 180,
  'id_card': 60,
  'driver_license': 60,
  'warranty': 14,
  'contract': 30,
};

/// Keyword rules, English and Turkish, matched on folded text. Weighted so a
/// strong signal ("poliçe", "passport") outranks incidental words.
const _signals = <String, Map<String, int>>{
  'insurance': {'police': 3, 'policy': 3, 'sigorta': 3, 'insurance': 3, 'kasko': 4, 'trafik sigortasi': 4, 'teminat': 2, 'coverage': 2, 'premium': 1, 'prim': 1},
  'vehicle_registration': {'ruhsat': 4, 'arac tescil': 4, 'vehicle registration': 4, 'sasi no': 3, 'motor no': 2, 'muayene': 3, 'plaka': 2},
  'passport': {'passport': 5, 'pasaport': 5, 'nationality': 1, 'uyrugu': 1, 'p<tur': 5},
  'id_card': {'kimlik karti': 5, 'identity card': 5, 'tc kimlik': 4, 'nufus': 3},
  'driver_license': {'surucu belgesi': 5, 'ehliyet': 5, 'driving licence': 5, "driver's license": 5, 'driver license': 5},
  'warranty': {'garanti': 4, 'warranty': 4, 'guarantee': 3, 'seri no': 1, 'serial number': 1},
  'invoice': {'fatura': 4, 'invoice': 4, 'kdv': 2, 'vat': 2, 'vergi no': 2, 'son odeme': 2, 'amount due': 2},
  'receipt': {'fis': 3, 'receipt': 4, 'toplam': 1, 'total': 1, 'nakit': 1, 'cash': 1},
  'contract': {'sozlesme': 4, 'contract': 4, 'agreement': 3, 'taraflar': 2, 'parties': 2, 'kira': 2, 'lease': 2},
  'travel': {'boarding pass': 5, 'binis karti': 5, 'flight': 2, 'ucus': 2, 'pnr': 3, 'reservation': 2, 'rezervasyon': 2, 'otel': 1, 'hotel': 1},
  'medical': {'recete': 4, 'prescription': 4, 'hasta': 2, 'patient': 2, 'teshis': 3, 'diagnosis': 3, 'hastane': 2, 'hospital': 2, 'tahlil': 3, 'laboratory': 2},
};

class Classification {
  const Classification(this.type, this.confidence);
  final String type;
  final double confidence;
}

Classification classifyDocument(String text, {String? fileName}) {
  final haystack = foldForSearch('${fileName ?? ''}\n$text');
  var best = 'other';
  var bestScore = 0;
  var total = 0;
  for (final entry in _signals.entries) {
    var score = 0;
    for (final signal in entry.value.entries) {
      if (_startsWord(haystack, signal.key)) score += signal.value;
    }
    total += score;
    if (score > bestScore) {
      best = entry.key;
      bestScore = score;
    }
  }
  if (bestScore < 3) return const Classification('other', 0.2);
  // Confidence: how much of the evidence points at the winner, capped.
  final share = bestScore / total;
  return Classification(best, (0.4 + 0.6 * share).clamp(0.0, 0.95));
}

/// True if [term] occurs at the start of a word. Suffixes are allowed, so
/// "sigorta" matches "sigortası", but "fis" does not match "ofis".
bool _startsWord(String haystack, String term) =>
    RegExp('(?:^|[^a-z0-9])${RegExp.escape(term)}').hasMatch(haystack);
