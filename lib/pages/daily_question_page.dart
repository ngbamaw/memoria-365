import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/models/question.dart';
import 'package:memoria/pages/response_history_page.dart';
import 'package:memoria/components/SelectableElement.dart';
import 'package:memoria/models/response.dart';
import 'package:memoria/utils/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DailyQuestionPage extends StatefulWidget {
  const DailyQuestionPage({Key? key}) : super(key: key);

  @override
  State<DailyQuestionPage> createState() => _DailyQuestionPageState();
}

class _DailyQuestionPageState extends State<DailyQuestionPage> {
  // final DateTime _date = DateTime(2023, 3, 5);
  final DateTime _date = DateTime.now();
  Question? _question;
  bool _editMode = true;
  final TextEditingController _textEditingController = TextEditingController();
  final _supabase = Supabase.instance.client;
  final onEditProps = {
    "firstButtonProps": {
      "label": "Historique des réponses",
      "onTap": (BuildContext context, DateTime date) {
        context.pushRoute(ResponseHistoryRoute(date: date));
      }
    },
    "secondButtonProps": {
      "label": "Valider",
      "onTap": (SupabaseClient client, Question question, Response response) async {
        final currentUser = client.auth.currentUser;
        if (currentUser != null) {
          print("Inserting response: ${response.text} for user: ${currentUser.id}");
          await client.from("response").insert({
            "id_user": currentUser.id,
            "text": response.text,
            "date": response.date,
            "question": question.id,
            "private": response.private
          });
        }
      }
    }
  };

  final onResponseProps = {
    "firstButtonProps": {"label": "Partager ma réponse avec mes amis", "onTap": (BuildContext context) {}},
    "secondButtonProps": {"label": "Ne pas partager ma réponse", "onTap": (SupabaseClient client) async {}}
  };

  dynamic _props;

  Future<dynamic> getQuestion() async {
    final data = await _supabase
        .from("question")
        .select("question, id, date")
        .eq("date", getDate(_date.copyWith(year: 2011))) as List<dynamic>;
    return data[0];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _props = _editMode ? onEditProps : onResponseProps;
    getQuestion().then((value) {
      setState(() {
        _question = Question(id: value["id"], question: value["question"], date: DateTime.parse(value["date"]));
      });
    });
  }

  final onValidatedProps = {
    "firstButtonProps": {"label": "Partager ma réponse avec mes amis", "onTap": (BuildContext context) async {}},
    "secondButtonProps": {"label": "Ne pas partager ma réponse", "onTap": (BuildContext context) async {}}
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final fullDate = getFullDate(_date);
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/fond-clair.jpg'), fit: BoxFit.cover)),
          child: Stack(
            children: [
              Positioned(
                  child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.router.push(const ChoiceDateRoute());
                      },
                      icon: const Icon(
                        Icons.event_note,
                        color: Color.fromRGBO(223, 133, 133, 1),
                        size: 30.0,
                      )),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        context.router.push(const SettingsRoute());
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Color.fromRGBO(223, 133, 133, 1),
                        size: 30.0,
                      )),
                ],
              )),
              Column(children: [
                Text("${fullDate["day"]}\n ${fullDate["month"]}",
                    style: themeData.textTheme.titleLarge?.copyWith(
                      fontSize: 48,
                    ),
                    textAlign: TextAlign.center),
                Text(fullDate["year"].toString(), style: themeData.textTheme.bodyMedium, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                Text(
                  _question?.question ?? "Chargement...",
                  style: themeData.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.3), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.3), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.3), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    hintText: 'Ecrivez ici',
                    hintStyle: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                    counterStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                  maxLength: 200,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                  controller: _textEditingController,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 0),
                              backgroundColor: const Color.fromRGBO(166, 112, 118, 1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0)),
                            ),
                            onPressed: () {
                              context.router.push(ResponseHistoryRoute(date: _date));
                            },
                            child: Text(
                              "Historique des réponses",
                              style: themeData.textTheme.titleLarge?.copyWith(
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 0),
                              backgroundColor: const Color.fromRGBO(223, 133, 133, 1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0)),
                            ),
                            onPressed: () async {
                              final response =
                                  Response(text: _textEditingController.text, date: getDate(_date), private: false);
                              final currentUser = _supabase.auth.currentUser;
                              if (currentUser != null) {
                                await _supabase.from("response").insert({
                                  "id_user": currentUser.id,
                                  "text": response.text,
                                  "date": response.date,
                                  "question": _question?.id,
                                  "private": response.private
                                });
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
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Attention : après validation, vous ne pourrez plus modifier votre réponse.",
                          style:
                              themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.5)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ],
          )),
    );
  }
}
