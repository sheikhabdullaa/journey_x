import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// LOGIN
  Future<String?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      User? user = userCredential.user;

      if (user == null) {
        return 'User account not found.';
      }

      await user.reload();
      user = _auth.currentUser;

      if (user == null) {
        return 'Unable to load user account.';
      }

      if (!user.emailVerified) {
        await _auth.signOut();
        return 'Please verify your email first.';
      }

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthError(e);
    } catch (e) {
      return 'Login failed. Please try again.';
    }
  }

  /// SIGNUP
  Future<String?> signup(
    String email,
    String password,
    String name,
    int number,
  ) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      final User? user = userCredential.user;

      if (user == null) {
        return 'Account could not be created.';
      }

      // Firebase verification email send karega
      await user.sendEmailVerification();

      // User information Firestore mein save hogi
      await _firestore.collection('signupuser').doc(user.uid).set({
        'uid': user.uid,
        'name': name.trim(),
        'email': email.trim(),
        'number': number,
        'emailVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Verification screen par polling/resend ke liye user signed-in rahega.
      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthError(e);
    } on FirebaseException catch (e) {
      // Agar Firestore save fail ho to Firebase Auth account remove karein
      // taake duplicate/incomplete account create na rahe.
      try {
        await _auth.currentUser?.delete();
      } catch (_) {}

      return e.message ?? 'User data could not be saved.';
    } catch (e) {
      return 'Signup failed. Please try again.';
    }
  }

  /// RESEND EMAIL VERIFICATION
  Future<String?> resendVerificationEmail() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        return 'Your session has expired. Please sign in again.';
      }

      await user.reload();

      final User? refreshedUser = _auth.currentUser;

      if (refreshedUser == null) {
        return 'Your session has expired. Please sign in again.';
      }

      if (refreshedUser.emailVerified) {
        return 'Your email is already verified.';
      }

      await refreshedUser.sendEmailVerification();

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthError(e);
    } catch (e) {
      return 'Verification email could not be sent.';
    }
  }

  /// CHECK EMAIL VERIFICATION
  Future<bool> checkEmailVerification() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        return false;
      }

      await user.reload();

      final User? refreshedUser = _auth.currentUser;
      final bool verified = refreshedUser?.emailVerified ?? false;

      if (verified) {
        await _firestore
            .collection('signupuser')
            .doc(refreshedUser!.uid)
            .update({
              'emailVerified': true,
              'verifiedAt': FieldValue.serverTimestamp(),
            });
      }

      return verified;
    } catch (_) {
      return false;
    }
  }

  /// FORGOT PASSWORD
  Future<String?> forgotPassword(String email) async {
    try {
      if (email.trim().isEmpty) {
        return 'Please enter your email address.';
      }

      await _auth.sendPasswordResetEmail(email: email.trim());

      return null;
    } on FirebaseAuthException catch (e) {
      return _getAuthError(e);
    } catch (e) {
      return 'Password reset email could not be sent.';
    }
  }

  /// SEND PASSWORD RESET
  Future<String?> sendPasswordReset(String email) async {
    return forgotPassword(email);
  }

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// CURRENT USER
  User? get currentUser => _auth.currentUser;

  /// USER LOGGED IN OR NOT
  bool get isLoggedIn => _auth.currentUser != null;

  /// FIREBASE ERROR MESSAGES
  String _getAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Email or password is incorrect.';

      case 'email-already-in-use':
        return 'An account already exists with this email.';

      case 'weak-password':
        return 'Password must contain at least 6 characters.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'network-request-failed':
        return 'Please check your internet connection.';

      case 'operation-not-allowed':
        return 'Email/password authentication is not enabled.';

      case 'requires-recent-login':
        return 'Please log in again and retry.';

      default:
        return e.message ?? 'Authentication failed.';
    }
  }
}
