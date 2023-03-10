import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/utils/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key, required this.year}) : super(key: key);

  final int year;
  
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List? _responses = [];
  final _supabase = Supabase.instance.client;
  
  CalendarPage get page => super.widget as CalendarPage;

  getResponses() async {
    final response =
        await _supabase.from('response').select('text, date, private').eq('id_user', _supabase.auth.currentUser!.id);
    setState(() {
      _responses = response;
    });
  }

  dateInResponsesList(DateTime date) {
    print(date);
    for (var i = 0; i < _responses!.length; i++) {
      if (_responses![i]['date'] == getDate(date)) {
        return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    getResponses();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/fond-clair.jpg'), fit: BoxFit.cover)),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    context.router.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
              Column(children: [
                Text("Calendrier", style: themeData.textTheme.titleLarge),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 24),
                    itemCount: 12,
                    itemBuilder: (ctx, monthIndex) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${months[monthIndex]} ${page.year}",
                          style: themeData.textTheme.titleLarge?.copyWith(
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 7,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            children: [
                              ...List.generate(
                                  35,
                                  (index) => Container(
                                        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                                        child: Stack(
                                          children: [
                                            if (index < DateTime(page.year, monthIndex + 2, 0).day)
                                              Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: "Acumin",
                                                        decoration: TextDecoration.none),
                                                  )),
                                            if (index < DateTime(page.year, monthIndex + 2, 0).day &&
                                                dateInResponsesList(DateTime(page.year, monthIndex + 1, index + 1)))
                                              Positioned(
                                                  child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    context.router.push(
                                                        ResponseRoute(date: DateTime(page.year, monthIndex + 1, index + 1)));
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(6.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white, shape: BoxShape.circle),
                                                  ),
                                                ),
                                              ))
                                          ],
                                        ),
                                      )),
                            ]),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24 - 16),
                  child: Text("Qulle date souhaitez-vous revoir ?", style: themeData.textTheme.bodyMedium),
                ),
              ]),
            ],
          )),
    );
  }
}
