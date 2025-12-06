import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {
  final supabase = Supabase.instance.client;

  // ---------------- GET THE USER'S NAME  ----------------
  User? getCurrentUser() {
  return supabase.auth.currentUser;
  }

  // ---------------- SIGN UP ----------------
  Future<AuthResponse> signUp(String email, String password, String fullName) async {
    return await supabase.auth.signUp(
    email: email,
    password: password,
    data: {
      'full_name': fullName,
    },
  );
}

  // ---------------- EMAIL + PASSWORD LOGIN ----------------
  Future<AuthResponse> signInWithPassword(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // ---------------- OTP LOGIN (EMAIL CODE) ----------------
  Future<void> sendOtp(String email) async {
    return await supabase.auth.signInWithOtp(
      email: email,
      emailRedirectTo: 'io.supabase.flutter://signin-callback/',
      );
  }
}
