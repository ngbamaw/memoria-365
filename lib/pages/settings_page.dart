import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:memoria/app_router.gr.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<dynamic> listActions = [
    {
      "title": "Nom d'utilisateur",
      "action": (BuildContext context) =>
          () => context.router.push(ChangeFieldUserRoute(title: "Nom d'utilisateur", field: "username"))
    },
    {"title": "Numéro de téléphone",
      "action": (BuildContext context) =>
          () => context.router.push(ChangeFieldUserRoute(title: "Numéro de téléphone", field: "phone"))},
    {"title": "Adresse Email",
      "action": (BuildContext context) =>
          () => context.router.push(ChangeFieldUserRoute(title: "Adresse", field: "email"))},
    {"title": "Mot de passe",
      "action": (BuildContext context) =>
          () => context.router.push(ChangeFieldUserRoute(title: "Mot de passe", field: "username"))},
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Color.fromRGBO(11, 19, 32, 0)),
      child: Column(
        children: [
          Text("Réglages", style: themeData.textTheme.titleLarge),
          const SizedBox(height: 24),
          Column(children: [
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...listActions.map((e) =>TextButton(
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
                      ))),
                ],
              ),
            )
          ])
        ],
      ),
    );
  }
}
