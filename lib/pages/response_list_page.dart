import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/components/response_block.dart';
import 'package:memoria/models/question.dart';
import 'package:memoria/models/response.dart';
import 'package:memoria/utils/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResponseListForPrivate extends StatelessWidget {
  const ResponseListForPrivate({Key? key, required this.onChangePrivacy}) : super(key: key);

  final void Function()? onChangePrivacy;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
          child: Column(
            children: [
              Text("Réponse confidentielle", style: themeData.textTheme.titleLarge, textAlign: TextAlign.center),
              const SizedBox(height: 2),
              Text("Vous pourrez comparer la réponse dans un an et admirer votre évolution",
                  style: themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.5)),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: onChangePrivacy,
          child: Text("Je veux finalement partager ma réponse",
              style: themeData.textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}

class ResponseListForPublic extends StatelessWidget {
  const ResponseListForPublic({Key? key, required this.onChangePrivacy, required this.responses}) : super(key: key);

  final void Function()? onChangePrivacy;
  final List<dynamic>? responses;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        const SizedBox(height: 4),
        TextButton(
          onPressed: onChangePrivacy,
          child: Text("Je veux finalement partager ma réponse",
              style: themeData.textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 4),
        ...?responses
            ?.map((e) => ResponseBlock(
                  response: e["response"] ?? "Chargement...",
                  author: e["friend"]["username"].toString() ?? "Chargement...",
                ))
            .toList(),
      ],
    );
  }
}

class ResponseListPage extends StatefulWidget {
  const ResponseListPage({Key? key}) : super(key: key);

  @override
  State<ResponseListPage> createState() => _ResponseListPageState();
}

class _ResponseListPageState extends State<ResponseListPage> {
  final DateTime _date = DateTime(2023, 3, 5);
  Question? _question;
  Response? _response;
  List<dynamic>? _responses;
  final _supabase = Supabase.instance.client;

  Future<dynamic> getQuestion() async {
    final data = await _supabase
        .from("question")
        .select("question, id, date")
        .eq("date", getDate(_date.copyWith(year: 2011))) as List<dynamic>;
    return data[0];
  }

  Future<dynamic> getResponse() async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser != null) {
      final data = await _supabase
          .from("response")
          .select("text, date, private")
          .eq("id_user", currentUser.id)
          .eq("date", getDate(_date)) as List<dynamic>;
      return data[0];
    }
    return null;
  }

  Future<dynamic> getResponseFromFriends() async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser != null) {
      final userIds = await _supabase
          .from("friend")
          .select("id_from, id_to")
          .or("id_from.eq.${currentUser.id}, id_to.eq.${currentUser.id}") as List<dynamic>;

      var friendIds = [];
      for (var userId in userIds) {
        if (userId["id_from"] != currentUser.id) {
          friendIds.add(userId["id_from"]);
        } else {
          friendIds.add(userId["id_to"]);
        }
      }

      var friends = [];
      for (var friendId in friendIds) {
        final friend = await _supabase.from("profile").select("id, username").eq("id", friendId) as List<dynamic>;
        friends.add(friend[0]);
      }

      var responses = [];
      for (var friend in friends) {
        final response = await _supabase
            .from("response")
            .select("text, date, private")
            .eq("id_user", friend["id"])
            .eq("date", getDate(_date)) as List<dynamic>;
        responses.add({"response": response[0]["text"], "friend": friend});
      }

      return responses;
    }
    return null;
  }

  Future<void> setResponsePrivate() async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser != null) {
      await _supabase
          .from("response")
          .update({"private": true})
          .eq("id_user", currentUser.id)
          .eq("date", getDate(_date));
    }
  }

  Future<void> setResponsePublic() async {
    final currentUser = _supabase.auth.currentUser;
    if (currentUser != null) {
      await _supabase
          .from("response")
          .update({"private": false})
          .eq("id_user", currentUser.id)
          .eq("date", getDate(_date));
    }
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

    getResponseFromFriends().then((value) {
      setState(() {
        _responses = value;
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
                Text("${fullDate["day"]}\n${fullDate["month"]}",
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
                Expanded(
                  child: ListView(children: [
                    const SizedBox(height: 12),
                    ResponseBlock(
                      response: _response?.text ?? "Chargement...",
                      author: _response?.private != true ? "Moi | sarahdesalest" : null,
                    ),
                    if (_response?.private == true)
                      ResponseListForPrivate(onChangePrivacy: () {
                        setResponsePublic().then((value) {
                          setState(() {
                            _response?.private = false;
                          });
                        });
                      })
                    else
                      ResponseListForPublic(
                          responses: _responses,
                          onChangePrivacy: () {
                            setResponsePrivate().then((value) {
                              setState(() {
                                _response?.private = true;
                              });
                            });
                          }),
                  ]),
                ),
                const SizedBox(height: 24),
                Text("On se retrouve demain pour une une autre question !",
                    style: themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.5)),
                    textAlign: TextAlign.center)
              ]),
            ],
          )),
    );
  }
}
