class CardModel {
  final int? id;
  final String bank;
  final String last4;
  final String encryptedPin;

  CardModel({
    this.id,
    required this.bank,
    required this.last4,
    required this.encryptedPin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bank': bank,
      'last4': last4,
      'pin': encryptedPin,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      bank: map['bank'],
      last4: map['last4'],
      encryptedPin: map['pin'],
    );
  }
}
