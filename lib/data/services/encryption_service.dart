import 'package:encrypt/encrypt.dart';

class EncryptionService {
  static final _key = Key.fromUtf8('16charSecretKey!');
  static final _iv = IV.fromLength(16);

  static String encryptPin(String pin) {
    final encrypter = Encrypter(AES(_key));
    return encrypter.encrypt(pin, iv: _iv).base64;
  }

  static String decryptPin(String encrypted) {
    final encrypter = Encrypter(AES(_key));
    return encrypter.decrypt64(encrypted, iv: _iv);
  }
}
