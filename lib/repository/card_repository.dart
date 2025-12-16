// import '../data/db/database_helper.dart';
// import '../models/card_model.dart';

// class CardRepository {
//   final db = DatabaseHelper.instance;

//   Future<void> insertCard(CardModel card) async {
//     final database = await db.database;
//     await database.insert('cards', card.toMap());
//   }

//   Future<CardModel?> getCardByLast4(String last4) async {
//     final database = await db.database;
//     final result = await database.query(
//       'cards',
//       where: 'last4 = ?',
//       whereArgs: [last4],
//     );

//     if (result.isNotEmpty) {
//       return CardModel.fromMap(result.first);
//     }
//     return null;
//   }
// }
import '../data/db/database_helper.dart';
import '../models/card_model.dart';

class CardRepository {
  final db = DatabaseHelper.instance;

  Future<void> insertCard(CardModel card) async {
    final database = await db.database;
    await database.insert('cards', card.toMap());

    print("-->> CARD SAVED:");
    print(card.toMap());
  }

  Future<CardModel?> getCardByLast4(String last4) async {
    final database = await db.database;
    final result = await database.query(
      'cards',
      where: 'last4 = ?',
      whereArgs: [last4],
    );

    print("--->> SEARCH last4=$last4 → $result");

    if (result.isNotEmpty) {
      return CardModel.fromMap(result.first);
    }
    return null;
  }

  
  Future<void> debugPrintAllCards() async {
    final database = await db.database;
    final result = await database.query('cards');

    print("--->> ALL SAVED CARDS:");
    print(result);
  }

  Future<List<CardModel>> getAllCards() async {
  final database = await db.database;
  final result = await database.query('cards');

  return result.map((e) => CardModel.fromMap(e)).toList();
}

}
