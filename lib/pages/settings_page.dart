import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _supabase = Supabase.instance.client;

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  List listActions = [
    [
      {"title": "Ajouter un ami", "action": (BuildContext context) => () => null}
    ],
    [
      {
        "title": "Nom d'utilisateur",
        "action": (BuildContext context) => () => context.router.push(ChangeFieldUserRoute(
              title: "Nom d'utilisateur",
              field: "profile.username",
            ))
      },
      {
        "title": "Numéro de téléphone",
        "action": (BuildContext context) => () => context.router
            .push(ChangeFieldUserRoute(title: "Numéro de téléphone", field: "user.phone", initialValue: "+33612345678"))
      },
      {
        "title": "Adresse email",
        "action": (BuildContext context) =>
            () => context.router.push(ChangeFieldUserRoute(title: "Adresse email", field: "user.email"))
      },
      {
        "title": "Mot de passe",
        "action": (BuildContext context) =>
            () => context.router.push(ChangeFieldUserRoute(title: "Mot de passe", field: "user.password"))
      },
    ],
    [
      {"title": "Politique de confidentialité", "action": (BuildContext context) => () => null},
      {
        "title": "Changer d'abonnement",
        "action": (BuildContext context) => () => context.router.push(const SubscriptionRoute())
      },
      {"title": "Aide", "action": (BuildContext context) => () => null},
      {"title": "Réseaux sociaux", "action": (BuildContext context) => () => null},
    ],
    [
      {"title": "Supprimer mon compte", "action": (BuildContext context) => () => null},
      {
        "title": "Deconnexion",
        "action": (BuildContext context) => () async {
              final supabase = Supabase.instance.client;
              await supabase.auth.signOut();
              if (context.mounted) context.router.push(const LoginRoute());
            }
      },
    ]
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Color.fromRGBO(11, 19, 32, 1)),
      child: Column(
        children: [
          Text("Réglages", style: themeData.textTheme.titleLarge),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(children: [
              ...listActions.map((list) => Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24), color: const Color.fromRGBO(24, 32, 45, 1)),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...list.map((e) => TextButton(
                                onPressed: e["action"](context),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(e["title"], style: themeData.textTheme.bodyLarge),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      decoration: const BoxDecoration(color: Colors.white),
                                    )
                                  ],
                                )))
                          ],
                        ),
                      ),
                      const SizedBox(height: 24)
                    ],
                  ))
            ]),
          )
        ],
      ),
    );
  }
}
