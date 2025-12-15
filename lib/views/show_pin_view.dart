import 'package:flutter/material.dart';
import 'package:pinchecker/util/biometric_auth.dart';
import 'package:provider/provider.dart';

import '../controllers/card_controller.dart';
import '../data/services/encryption_service.dart';

class ShowPinView extends StatefulWidget {
  const ShowPinView({super.key});

  @override
  State<ShowPinView> createState() => _ShowPinViewState();
}

class _ShowPinViewState extends State<ShowPinView> {
  bool _showPin = false;

  @override
  void initState() {
    super.initState();

    // Auto-hide PIN after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _showPin = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CardController>();
    final card = controller.matchedCard;

    if (card == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Result")),
        body: const Center(
          child: Text("No matching card found."),
        ),
      );
    }

    final pin = EncryptionService.decryptPin(card.encryptedPin);

    return Scaffold(
      appBar: AppBar(title: const Text("Your PIN")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              card.bank,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              "**** ${card.last4}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              _showPin ? pin : "••••",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
  onPressed: () async {
    final success = await BiometricAuth.authenticate(
      reason: 'Authenticate to view your PIN',
    );

    if (success) {
      setState(() => _showPin = true);
    }
  },
  child: const Text("Reveal PIN"),
)

            // ElevatedButton(
            //   onPressed: () {
            //     setState(() => _showPin = true);
            //   },
            //   child: const Text("Reveal PIN"),
            // )
          ],
        ),
      ),
    );
  }
}
