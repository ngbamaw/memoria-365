import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:memoria/components/SelectableElement.dart';
import 'package:memoria/models/response.dart';
import 'package:memoria/utils/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResponsePage extends StatefulWidget {
  const ResponsePage({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  State<ResponsePage> createState() => _ResponsePageState();
}

class _ResponsePageState extends State<ResponsePage> {
  final _supabase = Supabase.instance.client;
  ResponsePage get responsePage => super.widget;
  String? _response;

  Future<Response?> getResponse(String date) async {
    final data = await _supabase.from("response").select("text, date, private").eq("date", date) as List<dynamic>;

    if (data.isEmpty) {
      return null;
    }

    final response = Response(text: data[0]["text"], date: data[0]["date"], private: data[0]["private"]);
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResponse(getDate(responsePage.date)).then((value) {
      setState(() {
        _response = value?.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    var fullDate = getFullDate(responsePage.date);
    _supabase.auth.refreshSession();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/fond-clair.jpg'), fit: BoxFit.cover)),
        child: Column(children: [
          Text("${fullDate['day']}\n ${fullDate['month']}",
              style: themeData.textTheme.titleLarge?.copyWith(
                fontSize: 48,
              ),
              textAlign: TextAlign.center),
          Text(fullDate['year'].toString(), style: themeData.textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text(
            "Quelles sont vos résolutions pour cette année ?",
            style: themeData.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 24 * 8,
            child: DottedBorder(
              color: const Color.fromRGBO(255, 255, 255, 0.3),
              strokeWidth: 2,
              dashPattern: const [4],
              borderType: BorderType.RRect,
              radius: const Radius.circular(28),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  _response ?? "Il n'y a pas de réponse à cette date",
                  style: TextStyle(
                      color: Colors.white, fontStyle: _response != null ? FontStyle.normal : FontStyle.italic),
                  textAlign:  _response != null ? TextAlign.left : TextAlign.center,
                ),
              ),
              /*child: Text(
                    "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue.",
                  style: themeData.textTheme.bodyLarge,
                )*/
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 0),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 0),
                        backgroundColor: const Color.fromRGBO(223, 133, 133, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0)),
                      ),
                      onPressed: () => context.popRoute(),
                      child: Text(
                        "Retour",
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
                    "Admirez votre évolution !",
                    style: themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.5)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
