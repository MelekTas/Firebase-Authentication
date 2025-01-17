import 'package:firebase_2/Features/auth/views/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void   main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
);
  runApp(const ProviderScope(child: MyApp())); //riverpod eklediğimiz için providerScope eklemeliyiz kök kısmına.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignIn(),
    );
  }
}


