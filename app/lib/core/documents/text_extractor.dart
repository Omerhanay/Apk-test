import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdfrx/pdfrx.dart';

/// Reads the text of a document, one string per page. Everything runs on the
/// device: nothing is uploaded to read a document.
abstract interface class TextExtractor {
  Future<List<String>> extract(Uint8List bytes, String mimeType);
}

/// PDF text layer via PDFium (pdfrx); photos and scanned pages via Google ML
/// Kit's on-device Latin-script recognizer, which covers Turkish letters.
class DeviceTextExtractor implements TextExtractor {
  /// A PDF page with less text than this is treated as a scan and OCR'd.
  static const _minTextLayerChars = 20;
  static const _renderWidth = 1600.0;

  @override
  Future<List<String>> extract(Uint8List bytes, String mimeType) async {
    if (mimeType == 'application/pdf') return _pdf(bytes);
    return [await _ocrBytes(bytes, extension: mimeType == 'image/png' ? 'png' : 'jpg')];
  }

  Future<List<String>> _pdf(Uint8List bytes) async {
    final doc = await PdfDocument.openData(bytes);
    try {
      final pages = <String>[];
      for (final page in doc.pages) {
        final text = (await page.loadText())?.fullText.trim() ?? '';
        if (text.length >= _minTextLayerChars) {
          pages.add(text);
          continue;
        }
        final image = await page.render(
          fullWidth: _renderWidth,
          fullHeight: _renderWidth * page.height / page.width,
          backgroundColor: 0xffffffff,
        );
        if (image == null) {
          pages.add(text);
          continue;
        }
        try {
          pages.add(await _ocrBytes(await _toPng(image.pixels, image.width, image.height), extension: 'png'));
        } finally {
          image.dispose();
        }
      }
      return pages;
    } finally {
      await doc.dispose();
    }
  }

  Future<Uint8List> _toPng(Uint8List bgra, int width, int height) async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(bgra);
    final descriptor = ui.ImageDescriptor.raw(buffer, width: width, height: height, pixelFormat: ui.PixelFormat.bgra8888);
    final codec = await descriptor.instantiateCodec();
    final frame = await codec.getNextFrame();
    final png = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    frame.image.dispose();
    codec.dispose();
    descriptor.dispose();
    buffer.dispose();
    return png!.buffer.asUint8List();
  }

  /// ML Kit reads from a file path. The plaintext image exists only for the
  /// duration of recognition, in the app's private cache, and is then deleted.
  Future<String> _ocrBytes(Uint8List bytes, {required String extension}) async {
    final dir = await getTemporaryDirectory();
    final file = File(p.join(dir.path, 'ocr_${DateTime.now().microsecondsSinceEpoch}.$extension'));
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      await file.writeAsBytes(bytes, flush: true);
      final result = await recognizer.processImage(InputImage.fromFilePath(file.path));
      return result.text;
    } finally {
      await recognizer.close();
      if (await file.exists()) await file.delete();
    }
  }
}
