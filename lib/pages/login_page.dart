import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/components/InputField.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.onLoginCallback}) : super(key: key);
  final Function() onLoginCallback;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email = '';
  String password = '';

  LoginPage get loginPage => super.widget;


  Future<void> onSignIn(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _supabase.auth.signInWithPassword(email: email, password: password);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Connexion réussie")));
        loginPage.onLoginCallback();
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(48),
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/fond-clair.jpg'), fit: BoxFit.cover)),
          child: Column(children: [
            Text("Connectez-vous", style: themeData.textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 120),
            Form(
              key: _formKey,
                child: Column(
              children: [
                InputField(type: TextInputType.emailAddress, label: "Email", onSaved: (value) => email = value!),
                const SizedBox(height: 40),
                Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 12,
                      child: Text("Oublié?",
                          style: themeData.textTheme.bodyMedium
                              ?.copyWith(fontSize: 12, decoration: TextDecoration.underline)),
                    ),
                    InputField(
                        type: TextInputType.visiblePassword,
                        label: "Mot de passe",
                        obscure: true,
                        onSaved: (value) => password = value!),
                  ],
                ),
                const SizedBox(height: 40),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                    backgroundColor: const Color.fromRGBO(50, 72, 85, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0)),
                  ),
                  onPressed: () => onSignIn(context),
                  child: Text(
                    "Connexion",
                    style: themeData.textTheme.titleLarge,
                  ),
                ),
              ],
            )),
            const Spacer(),
            Row(
              children: [
                const Text("Vous n'avez pas de compte ?"),
                TextButton(
                    onPressed: () => context.router.replace(const RegisterRoute()),
                    child: Text(
                      "Inscrivez-vous",
                      style: themeData.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ])),
    );
  }


}
