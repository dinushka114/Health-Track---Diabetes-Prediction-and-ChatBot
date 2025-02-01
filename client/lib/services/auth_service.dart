import 'package:client/models/auth_response.dart';
import 'package:client/models/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  void saveUserDetails(String fullName, String email, String uid) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('users').child(uid);

    DatabaseReference newUserRef = databaseReference.push();

    await newUserRef.set({"fullName": fullName, "email": email});
  }

  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      saveUserDetails(fullName, email, credential.user!.uid);
      return AuthResponse(user: credential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return AuthResponse(message: "Email is already in use");
      } else {
        return AuthResponse(message: "An error occured");
      }
    }
  }

  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthResponse(user: credential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return AuthResponse(message: "Invalid email or password");
      } else {
        return AuthResponse(message: "An error occured");
      }
    }
  }

  Future<UserProfile> getCurrentUserProfile() async {
    final String uid = getCurrentUser()!.uid;
    late UserProfile profile;

    DatabaseReference profileRef = FirebaseDatabase.instance.ref('users/$uid');
    DatabaseEvent event = await profileRef.once();

    if (event.snapshot.exists) {
      Map<dynamic, dynamic> bookings =
          event.snapshot.value as Map<dynamic, dynamic>;
      bookings.forEach((key, value) {
        profile = UserProfile.fromJson(Map<String, dynamic>.from(value));
      });
    } else {
      print('No bookings found for current user');
    }
    return profile;
  }
}
