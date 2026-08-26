import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password , );
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup(
    String email,
    String password,
    String name,
    int number,
  ) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseFirestore.instance
          .collection('signupuser')
          .doc(user.user?.uid)
          .set({'name': name, 'email': email, 'password': password , 'number': number});

      // ignore: avoid_returning_null_for_void
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendPasswordReset(String trim) async {}

  Future<void> logout() async {}
}
