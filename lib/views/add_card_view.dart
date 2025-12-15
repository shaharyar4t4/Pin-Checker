import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/card_controller.dart';
import '../models/card_model.dart';
import '../data/services/encryption_service.dart';

class AddCardView extends StatelessWidget {
  final bankCtrl = TextEditingController();
  final last4Ctrl = TextEditingController();
  final pinCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Card")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: bankCtrl, decoration: InputDecoration(labelText: "Bank")),
            TextField(controller: last4Ctrl, decoration: InputDecoration(labelText: "Last 4 digits")),
            TextField(controller: pinCtrl, decoration: InputDecoration(labelText: "PIN")),
            ElevatedButton(
  onPressed: () async {
    print("🟢 SAVE BUTTON CLICKED");

    final encrypted =
        EncryptionService.encryptPin(pinCtrl.text);

    final card = CardModel(
      bank: bankCtrl.text,
      last4: last4Ctrl.text,
      encryptedPin: encrypted,
    );

    await context.read<CardController>().saveCard(card);
  },
  child: const Text("Save"),
)

            // ElevatedButton(
            //   onPressed: () {
            //     final encrypted = EncryptionService.encryptPin(pinCtrl.text);
            //     final card = CardModel(
            //       bank: bankCtrl.text,
            //       last4: last4Ctrl.text,
            //       encryptedPin: encrypted,
            //     );
            //     context.read<CardController>().saveCard(card);
            //   },
            //   child: Text("Save"),
            // )
          ],
        ),
      ),
    );
  }
}
