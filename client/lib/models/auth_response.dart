import 'package:firebase_auth/firebase_auth.dart';

class AuthResponse {
  User? user;
  String? message;

  AuthResponse({this.user, this.message});
}
