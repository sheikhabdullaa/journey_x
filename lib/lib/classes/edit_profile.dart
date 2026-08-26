import 'package:firebase_auth/firebase_auth.dart';
import 'package:journey_x/lib/classes/sarah_model_class.dart';

final firebaseUser = FirebaseAuth.instance.currentUser!;

final appUser = AppUser(
  uid: firebaseUser.uid,
  name: 'Sarah Smith',
  email: firebaseUser.email!,
  phoneNumber: '03001234567',
  password: 'password123',
);

// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (_) => SarahEditProfile(user: appUser),
//   ),
// );
