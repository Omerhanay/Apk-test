import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class PickedDocument {
  const PickedDocument({required this.name, required this.mimeType, required this.bytes});
  final String name;
  final String mimeType;
  final Uint8List bytes;
}

/// Gets a file from the system picker or the camera. Overridable in tests.
abstract interface class DocumentPicker {
  Future<PickedDocument?> pickFile();
  Future<PickedDocument?> takePhoto();
}

/// System document picker (Storage Access Framework, no storage permission)
/// and the camera app via an intent (no camera permission).
class SystemDocumentPicker implements DocumentPicker {
  @override
  Future<PickedDocument?> pickFile() async {
    final files = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png']);
    if (files.isEmpty) return null;
    final file = files.first;
    return PickedDocument(name: file.name, mimeType: mimeTypeFor(file.name), bytes: await file.xFile.readAsBytes());
  }

  @override
  Future<PickedDocument?> takePhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 85, maxWidth: 2400);
    if (photo == null) return null;
    return PickedDocument(name: photo.name, mimeType: 'image/jpeg', bytes: await photo.readAsBytes());
  }
}

String mimeTypeFor(String name) => switch (p.extension(name).toLowerCase()) {
      '.pdf' => 'application/pdf',
      '.png' => 'image/png',
      '.jpg' || '.jpeg' => 'image/jpeg',
      _ => 'application/octet-stream',
    };
