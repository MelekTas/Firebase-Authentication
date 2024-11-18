import 'package:firebase_2/Features/auth/repostory/auth_repostory.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Bu kod parçası, Firebase ve Google Sign-In kullanarak bir Authentication (kimlik doğrulama) işlemi
//gerçekleştiren bir uygulamanın AuthController (Kimlik Doğrulama Kontrolcüsü) sayfasıdır.
// Bu kontrolcü sınıfı, kullanıcıların e-posta ve şifreyle giriş yapmasını ve kaydolmasını sağlar.
// Ayrıca, bu işlemleri yönetmek için Riverpod ve Firebase Authentication kullanır.

final authControllerProvider = Provider(
    (ref) => AuthController(authRepostory: ref.watch(authRepostoryProvider)));

class AuthController {
  final AuthRepostory authRepostory;
  AuthController({required this.authRepostory});

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return authRepostory.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return authRepostory.signUpWithEmailAndPassword(
        email: email, password: password);
  }

  Future<User?> signInWithGoogle() async {
    final User? user = await authRepostory.signInWithGoogle();
    return user; 
}
}