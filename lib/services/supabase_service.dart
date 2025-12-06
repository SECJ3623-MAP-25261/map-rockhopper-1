import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // ---------------- SIGN UP ----------------
  Future<AuthResponse> signUp(String email, String password) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
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
    await supabase.auth.signInWithOtp(
      email: email,
      emailRedirectTo: 'io.supabase.flutter://signin-callback/',
    );
  }
}