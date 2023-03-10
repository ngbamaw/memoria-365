import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/pages/login_page.dart';
import 'package:memoria/components/InputField.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _supabase = Supabase.instance.client;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String username = '';
  String email = '';
  String password = '';

  void onSignUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        final response = await _supabase.auth.signUp(email: email, password: password, data: {'username': username});
        await _supabase.from("profile").insert({"id": response.user?.id, "username": username});
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Inscription réussie")));
          context.router.push(const SubscriptionRoute());
        }
      } on AuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }

      setState(() {
        _isLoading = false;
      });
    }
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
            Text("Créez votre compte", style: themeData.textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 48),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField(
                        type: TextInputType.text, label: "Nom d'utilisateur", onSaved: (value) => username = value!),
                    const SizedBox(height: 40),
                    InputField(type: TextInputType.emailAddress, label: "Email", onSaved: (value) => email = value!),
                    const SizedBox(height: 40),
                    InputField(
                        type: TextInputType.visiblePassword,
                        obscure: true,
                        label: "Mot de passe",
                        onSaved: (value) => password = value!),
                    const SizedBox(height: 40),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                        backgroundColor: const Color.fromRGBO(50, 72, 85, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0)),
                      ),
                      onPressed: () => onSignUp(context),
                      child: Text(
                        "Inscription",
                        style: themeData.textTheme.titleLarge,
                      ),
                    ),
                  ],
                )),
            const Spacer(),
            Row(
              children: [
                const Text("Vous avez un compte ?"),
                TextButton(
                    onPressed: () => context.router.replace(LoginRoute(onLoginCallback: () => context.router.pop())),
                    child: Text(
                      "Connectez-vous",
                      style: themeData.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ])),
    );
  }
}
