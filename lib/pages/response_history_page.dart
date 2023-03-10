import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/pages/daily_question_page.dart';
import 'package:memoria/pages/response_page.dart';
import 'package:memoria/components/SelectableElement.dart';
import 'package:memoria/utils/index.dart';

class ResponseHistoryPage extends StatefulWidget {
  const ResponseHistoryPage({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  State<ResponseHistoryPage> createState() => _ResponseHistoryPageState();
}

class _ResponseHistoryPageState extends State<ResponseHistoryPage> {
  ResponseHistoryPage get responseHistoryPage => super.widget;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    var fullDate = getFullDate(responseHistoryPage.date);

    return Scaffold(
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
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
            GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 2.5,
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 8,
                children: [
                  ...List.generate(
                    15,
                        (index) =>
                        SizedBox(
                            height: 60,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(166, 112, 118, 1)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                var newDate = DateTime(2021 + index, responseHistoryPage.date.month, responseHistoryPage.date.day);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ResponsePage(date: newDate),
                                  ),
                                );
                              },
                              child: Text((2021 + index).toString(), style: const TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),

                              ),
                            )),
                    ],
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
                              onPressed: () => context.pushRoute(const DailyQuestionRoute()),
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
                            "Qu'avez-vous réponddu les années précédentes ?",
                            style: themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.5)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
