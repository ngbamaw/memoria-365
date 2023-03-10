import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/pages/response_page.dart';
import 'package:memoria/utils/index.dart';

class ChoiceDatePage extends StatefulWidget {
  const ChoiceDatePage({Key? key}) : super(key: key);

  @override
  State<ChoiceDatePage> createState() => _ChoiceDatePageState();
}

class _ChoiceDatePageState extends State<ChoiceDatePage> {

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

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
                          context.router.pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
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
              const SizedBox(height: 150),
              Text(
                "Choisissez une année",
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
                                context.router.push(CalendarRoute(year: 2021 + index));
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
