import 'package:flutter/material.dart';

class ChangeFieldUserPage extends StatefulWidget {
  const ChangeFieldUserPage({Key? key, required this.title, required this.field}) : super(key: key);

  final String title;
  final String field;

  @override
  State<ChangeFieldUserPage> createState() => _ChangeFieldUserPageState();
}

class _ChangeFieldUserPageState extends State<ChangeFieldUserPage> {
  ChangeFieldUserPage get page => super.widget;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/fond-clair.jpg'), fit: BoxFit.cover)),
        child: Column(
          children: [
            Text(page.title, style: themeData.textTheme.titleLarge),
            const SizedBox(height: 24),
            Column(children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(24)),
                padding: const EdgeInsets.all(16),
                child: TextField(
                  style: themeData.textTheme.bodyLarge,
                    decoration: InputDecoration(
                        hintText: 'Entrez votre ${page.title.toLowerCase()}')),
              )
            ])
          ],
        ),
      ),
    );
  }
}
