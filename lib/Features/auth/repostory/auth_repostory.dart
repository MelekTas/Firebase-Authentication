import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';


final authRepostoryProvider=Provider((ref)=>AuthRepostory(firebaseauth: FirebaseAuth.instance));


class AuthRepostory {
  final FirebaseAuth firebaseauth;
    final firebaseAuth = FirebaseAuth.instance;

  AuthRepostory({
    required this.firebaseauth,
  });

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseauth.signInWithEmailAndPassword(
      email: email,
      password: password);
  }
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await firebaseauth.createUserWithEmailAndPassword(
      email: email,
      password: password);
  }
  
   Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      return userCredential.user; // Başarılı giriş sonrası user döndürülüyor
    }
  } catch (e) {
    print('Google ile giriş başarısız: $e');
  }
  return null; // Başarısız durumda null döndürülüyor
}


Future<void> signOutGoogle() async {
    try {
      await GoogleSignIn().signOut(); // Sadece Google oturumunu kapat
    } catch (e) {
      print('Google oturumundan çıkış yaparken hata oluştu: $e');
    }
  }
  }

 





