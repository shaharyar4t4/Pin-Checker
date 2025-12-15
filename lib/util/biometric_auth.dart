import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// Check if biometric or device lock is available
  static Future<bool> isAvailable() async {
    try {
      return await _auth.canCheckBiometrics ||
          await _auth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  static Future<bool> authenticate({
    String reason = 'Please authenticate to continue',
  }) async {
    try {
return await _auth.authenticate(
  localizedReason: reason,
  biometricOnly: false,
  sensitiveTransaction: true,
  persistAcrossBackgrounding: true,
  // options: const AuthenticationOptions(
  //   biometricOnly: false,
  //   stickyAuth: true,
  // ),
);

      
    } catch (e) {
      return false;
    }
  }
} 