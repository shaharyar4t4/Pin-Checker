import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CardScanService {
  static Future<String?> extractLast4(InputImage image) async {
    final recognizer = TextRecognizer();
    final result = await recognizer.processImage(image);

    final regex = RegExp(r'\b\d{4}\b');

    for (var block in result.blocks) {
      for (var line in block.lines) {
        final match = regex.firstMatch(line.text);
        if (match != null) {
          return match.group(0);
        }
      }
    }
    return null;
  }
}
