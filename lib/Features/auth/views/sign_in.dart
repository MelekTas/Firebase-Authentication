import 'package:firebase_2/Features/auth/controller/auth_controller.dart';
import 'package:firebase_2/Features/auth/repostory/auth_repostory.dart';
import 'package:firebase_2/Features/auth/views/sign_up.dart';
import 'package:firebase_2/Features/auth/views/welcome_page.dart';
import 'package:firebase_2/Features/home/home.dart';
import 'package:firebase_2/common/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/sign_in.png'),
              fit: BoxFit.cover,
            )),
          ),
          AspectRatio(
            aspectRatio: 1, //genişlik/yükseklik oranı=1 yapıldı yani bir kare.
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                              color: titleColor,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                      color: borderColor,
                                    ))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                      color: borderColor,
                                    ))),
                          ),
                        ),
                        Consumer(builder: (context, ref, child) {
                          return MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(authControllerProvider)
                                    .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    )
                                    .then(
                                      (value) => Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const Home(),
                                          ),
                                          (route) => false),
                                    );
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            color: buttonColor,
                            minWidth: double.infinity,
                            child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(color: containerColor),
                                )),
                          );
                        }),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () {},
                            child: const Text("Forgot Password ?",
                                style: TextStyle(
                                  color: subtitleColor,
                                  fontSize: 14.0,
                                )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  final user = await AuthRepostory(
                                          firebaseauth: FirebaseAuth.instance)
                                      .signInWithGoogle(); // Kullanıcıyı Google ile giriş yapması için çağırıyoruz.

                                  if (user != null) {
                                    // Eğer kullanıcı başarılı bir şekilde giriş yapmışsa
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomePage(),
                                      ),
                                    );
                                  } else {
                                    // Kullanıcı giriş yapmadıysa, burada bir hata mesajı gösterebilirsiniz
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Giriş işlemi başarısız.")),
                                    );
                                  }
                                } catch (e) {
                                  // Hata durumunu yakalayarak kullanıcıya bilgi verebilirsiniz
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Hata: $e")),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child: const Icon(
                                FontAwesomeIcons.google,
                                color: Colors.red,
                                size: 25.0,
                              ),
                            ),
                            const SizedBox(width: 15),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child: const Icon(
                                Icons.apple,
                                color: Colors.black,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don’t haven’t an account ?",
                                style: TextStyle(
                                  color: subtitleColor,
                                  fontSize: 12,
                                ),
                              ),
                              TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const SignUp())),
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: buttonColor,
                                      fontSize: 12,
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
