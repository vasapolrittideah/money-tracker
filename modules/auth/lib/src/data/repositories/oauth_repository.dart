import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared/shared.dart';

abstract class IOAuthRepository {
  Future<Either<Failure, Unit>> signInWithGoogle();
}

class OAuthRepository implements IOAuthRepository {
  OAuthRepository() {
    _initializeGoogleSignIn();
  }

  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  @override
  Future<Either<Failure, Unit>> signInWithGoogle() => ErrorHandler.handle(() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }

    final GoogleSignInAccount account = await _googleSignIn.authenticate(scopeHint: ['email']);

    // TODO: Commuinicate with backend server with Google ID token
    print('Google account auth: ${account.toString()}');

    return unit;
  });

  Future<void> _initializeGoogleSignIn() async {
    await _googleSignIn.initialize();
    _isGoogleSignInInitialized = true;
  }
}
