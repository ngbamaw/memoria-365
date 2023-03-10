import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangeFieldUserPage extends StatefulWidget {
  const ChangeFieldUserPage({Key? key, this.title, this.field, this.initialValue}) : super(key: key);

  final String? title;
  final String? field;
  final String? initialValue;

  @override
  State<ChangeFieldUserPage> createState() => _ChangeFieldUserPageState();
}

class _ChangeFieldUserPageState extends State<ChangeFieldUserPage> {
  ChangeFieldUserPage get page => super.widget;
  final _supabase = Supabase.instance.client;
  final textFieldController = TextEditingController();

  getUserField(String field) {
    switch (field) {
      case "email":
        return _supabase.auth.currentUser!.email;
      case "phone":
        return _supabase.auth.currentUser!.phone;
      default:
        return "";
    }
  }

  retrieveUserName() async {
    final profile = await _supabase
        .from("profile")
        .select("username")
        .eq("id", _supabase.auth.currentUser!.id);
    return profile[0]["username"];
  }

  @override
  void initState() {
    super.initState();
    final field = page.field!.split(".");
    if(field[0] == "user") {
      textFieldController.text = getUserField(field[1]);
    } else {
      retrieveUserName().then((value) => textFieldController.text = value);
    }
  }

  Future<void> _updateUserField() async {
    final field = page.field!.split(".");
    final text = textFieldController.text;

    if (field[0] == "user") {
      switch (field[1]) {
        case "email":
          await _supabase.auth.updateUser(
            UserAttributes(email: text),
          );
          break;
        case "password":
          await _supabase.auth.updateUser(
            UserAttributes(password: text),
          );
          break;
        case "phone":
          await _supabase.auth.updateUser(
            UserAttributes(phone: text),
          );
          break;
        default:
      }
    } else {
      await _supabase.from(field[0]).update({field[1]: text}).eq("id", _supabase.auth.currentUser!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(color: Color.fromRGBO(11, 19, 32, 1)),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  context.router.pop();
                },
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(page?.title ?? "Nom d'utilisateur",
                      style: themeData.textTheme.titleLarge, textAlign: TextAlign.center),
                ),
                const SizedBox(height: 24),
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24), color: const Color.fromRGBO(24, 32, 45, 1)),
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                        controller: textFieldController,
                        style: themeData.textTheme.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Entrez un ${page.title?.toLowerCase()}',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        )),
                  )
                ]),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 96),
                  child: Text("Vous pouvez le modifier à tout moment",
                      style: themeData.textTheme.bodyMedium, textAlign: TextAlign.center),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 0),
                          backgroundColor: const Color.fromRGBO(223, 133, 133, 1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0)),
                        ),
                        onPressed: () async {
                          await _updateUserField();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text("Changement effectué")));
                          }
                        },
                        child: Text(
                          "Valider",
                          style: themeData.textTheme.titleLarge?.copyWith(
                            fontSize: 42,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
