import 'package:flutter/material.dart';
import 'package:firebase_2/Features/auth/views/sign_in.dart'; 

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login Succesful!",
              style: TextStyle(fontSize: 25, color: Colors.green),
            ),
            const SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()), 
                );
              },
              child: const Text("Home"),
            ),
          ],
        ),
      ),
    );
  }
}
