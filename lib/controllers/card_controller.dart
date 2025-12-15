import 'package:flutter/material.dart';
import '../repository/card_repository.dart';
import '../models/card_model.dart';

class CardController extends ChangeNotifier {
  final CardRepository _repo = CardRepository();
  CardModel? matchedCard;

  Future<void> saveCard(CardModel card) async {
    print("➡️ saveCard() called");
    await _repo.insertCard(card);
    await _repo.debugPrintAllCards();
  }

  Future<void> findCard(String last4) async {
    print("➡️ findCard() called with $last4");
    matchedCard = await _repo.getCardByLast4(last4);
    notifyListeners();
  }
}

