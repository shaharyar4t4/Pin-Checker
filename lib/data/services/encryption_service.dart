// import 'package:encrypt/encrypt.dart';

// class EncryptionService {
//   static final _key = Key.fromUtf8('16charSecretKey!');
//   static final _iv = IV.fromLength(16);

//   static String encryptPin(String pin) {
//     final encrypter = Encrypter(AES(_key));
//     return encrypter.encrypt(pin, iv: _iv).base64;
//   }

//   static String decryptPin(String encrypted) {
//     final encrypter = Encrypter(AES(_key));
//     return encrypter.decrypt64(encrypted, iv: _iv);
//   }
// }
import 'package:encrypt/encrypt.dart';

class EncryptionService {
  static final Key _key =
      Key.fromUtf8('12345678901234567890123456789012');

  static final IV _iv = IV.fromLength(16);

  static Encrypter _encrypter = Encrypter(AES(_key, mode: AESMode.cbc, padding: 'PKCS7'));

  static String encryptPin(String pin) {
    return _encrypter.encrypt(pin, iv: _iv).base64;
  }

  static String decryptPin(String encrypted) {
    try {
      return _encrypter.decrypt64(encrypted, iv: _iv);
    } catch (e) {
      print("-->> DECRYPT ERROR: $e");
      return "----"; 
    }
  }

  
}
