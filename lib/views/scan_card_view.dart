import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:provider/provider.dart';

import '../controllers/card_controller.dart';
import 'show_pin_view.dart';

class ScanCardView extends StatefulWidget {
  const ScanCardView({super.key});

  @override
  State<ScanCardView> createState() => _ScanCardViewState();
}

class _ScanCardViewState extends State<ScanCardView> {
  bool _isScanning = false;
  final ImagePicker _picker = ImagePicker();

  /// 🔑 Extract ONLY card-number-based last4
  String? _extractLast4FromCard(String text) {
    // remove spaces & new lines
    final cleaned = text.replaceAll(RegExp(r'\s+'), '');

    // card numbers are usually 13–19 digits
    final regex = RegExp(r'\b\d{13,19}\b');

    final matches = regex.allMatches(cleaned);
    if (matches.isEmpty) return null;

    // take LAST match (usually the real card number)
    final cardNumber = matches.last.group(0)!;
    return cardNumber.substring(cardNumber.length - 4);
  }

  Future<void> _scanCard(BuildContext context) async {
    setState(() => _isScanning = true);

    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera);

    if (image == null) {
      setState(() => _isScanning = false);
      return;
    }

    final inputImage = InputImage.fromFile(File(image.path));
    final recognizer = TextRecognizer();

    final recognizedText = await recognizer.processImage(inputImage);
    await recognizer.close();

    setState(() => _isScanning = false);

    final fullText = recognizedText.text;
    final last4 = _extractLast4FromCard(fullText);

    print("-->> FULL OCR TEXT:\n$fullText");
    print("-->> SCANNED CARD last4 = $last4");

    if (last4 == null) {
      _showMessage("Card number not detected. Please try again.");
      return;
    }

    await context.read<CardController>().findCard(last4);

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ShowPinView()),
    );
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Card"),
      centerTitle: true,
      ),
      body: Center(
        child: _isScanning
            ? const CircularProgressIndicator()
            : ElevatedButton.icon(
                onPressed: () => _scanCard(context),
                icon: const Icon(Icons.camera_alt),
                label: const Text("Scan Card"),
              ),
      ),
    );
  }
}
