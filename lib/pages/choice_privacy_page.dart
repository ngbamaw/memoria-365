import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:memoria/models/question.dart';
import 'package:memoria/models/response.dart';
import 'package:memoria/utils/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChoicePrivacyPage extends StatefulWidget {
  const ChoicePrivacyPage({Key? key}) : super(key: key);

  @override
  State<ChoicePrivacyPage> createState() => _ChoicePrivacyPageState();
}

class _ChoicePrivacyPageState extends State<ChoicePrivacyPage> {
  DateTime _date = DateTime.now();
  Question? _question;
  Response? _response;
  final _supabase = Supabase.instance.client;

  Future<dynamic> getQuestion() async {
    final data = await _supabase.from("question").select("question, id, date").eq("date", getDate(_date.copyWith(year: 2011)))
        as List<dynamic>;
    return data[0];
  }

  Future<dynamic> getResponse() async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser != null) {
      final data = await _supabase.from("response").select("text, date, private").eq("id_user", currentUser.id).eq("date", getDate(_date))
          as List<dynamic>;
      return data[0];
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuestion().then((value) {
      setState(() {
        _question = Question(id: value["id"], question: value["question"], date: DateTime.parse(value["date"]));
      });
    });

    getResponse().then((value) {
      setState(() {
        _response = Response(text: value["text"], date: value["date"], private: value["private"]);
      });
    });
  }

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
          child: Column(children: [
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
            DottedBorder(
              color: const Color.fromRGBO(255, 255, 255, 1),
              strokeWidth: 2,
              dashPattern: const [4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: _response?.text ?? "Chargement...",
                    hintStyle: const TextStyle(color: Colors.white),
                    counter: const SizedBox.shrink(),
                  ),
                  enabled: false,
                  style: const TextStyle(color: Colors.white),
                  maxLength: 200,
                  maxLines: 8,
                  keyboardType: TextInputType.multiline,
                ),
              ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                          backgroundColor: const Color.fromRGBO(166, 112, 118, 1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0)),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Partager ma réponse avec mes amis",
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
                        onPressed: () async {},
                        child: Text(
                          "Ne pas partager ma réponse",
                          style: themeData.textTheme.titleLarge?.copyWith(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Vous pourrez changer d'avis plus tard",
                      style: themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.5)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}
