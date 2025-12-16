import 'package:flutter/material.dart';
import 'package:pinchecker/util/biometric_auth.dart';
import 'package:provider/provider.dart';

import '../controllers/card_controller.dart';
import '../data/services/encryption_service.dart';

class AllCardsView extends StatefulWidget {
  const AllCardsView({super.key});

  @override
  State<AllCardsView> createState() => _AllCardsViewState();
}

class _AllCardsViewState extends State<AllCardsView> {
  int? _visiblePinIndex;

  @override
  void initState() {
    super.initState();
    context.read<CardController>().loadAllCards();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CardController>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Saved Cards")),
      body: controller.allCards.isEmpty
          ? const Center(child: Text("No cards saved"))
          : ListView.builder(
              itemCount: controller.allCards.length,
              itemBuilder: (context, index) {
                final card = controller.allCards[index];
                final pin =
                    EncryptionService.decryptPin(card.encryptedPin);

                return Card(
                  margin: const EdgeInsets.all(12),
                  child: ListTile(
                    title: Text(
                      card.bank,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("**** ${card.last4}"),
                        const SizedBox(height: 6),
                        Text(
                          _visiblePinIndex == index ? pin : "••••",
                          style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 4,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        _visiblePinIndex == index
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () async {
                        final ok = await BiometricAuth.authenticate(
                          reason: 'Authenticate to view PIN',
                        );

                        if (!ok) return;

                        setState(() {
                          _visiblePinIndex =
                              _visiblePinIndex == index ? null : index;
                        });

                        // auto-hide after 5 sec
                        Future.delayed(const Duration(seconds: 5), () {
                          if (mounted) {
                            setState(() => _visiblePinIndex = null);
                          }
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
