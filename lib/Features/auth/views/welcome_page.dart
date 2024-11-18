import 'package:firebase_2/Features/auth/repostory/auth_repostory.dart';
import 'package:firebase_2/Features/auth/views/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Center(
        child: user == null
            ? const Text(
                'Hoşgeldin',
                style: TextStyle(fontSize: 24),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hoşgeldin, ${user.displayName ?? 'Kullanıcı'}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email ?? 'Email bilgisi bulunamadı',
                    style: const TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ));
                    },
                    child: const Text("Go Back!"),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(authRepostoryProvider).signOutGoogle(); // Google oturumunu kapat
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    child: const Text("Log Out"),
                  ),
                ],
              ),
      ),
    );
  }
}
