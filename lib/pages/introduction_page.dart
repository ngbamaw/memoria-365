import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:memoria/app_router.gr.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _IntroductionPageState();
  }
}

class _IntroductionPageState extends State<IntroductionPage> {
  static const titles = ['Chaque jour, \nune question', 'Preservez vos souvenirs', 'Gravez votre histoire', 'title'];

  int _activePage = 0;
  List<Widget> dots = [];

  final PageController _controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 4; i++) {
      dots.add(Container(
        height: 8,
        width: 8,
        decoration: const BoxDecoration(color: Colors.lightBlue, shape: BoxShape.circle),
      ));
    }
    _controller.addListener(() {
      setState(() {
        _activePage = _controller.page?.toInt() ?? 0;
      });
    });
  }

  @override
  void didUpdateWidget(covariant IntroductionPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final title = _activePage == 3
        ? SizedBox(
            height: 95,
            child: Column(
              children: [
                Text("365", style: themeData.textTheme.titleLarge?.copyWith(fontSize: 70)),
                Text("Memoria", style: themeData.textTheme.titleLarge?.copyWith(height: 0.5, fontSize: 50))
              ],
            ),
          )
        : SizedBox(
            height: 95,
            child: Text(
              titles[_activePage],
              style: themeData.textTheme.titleLarge?.copyWith(
                fontSize: 42,
              ),
              textAlign: TextAlign.center,
            ),
          );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(48),
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/fond-clair.jpg'), fit: BoxFit.cover)),
      child: Column(
        children: [
          title,
          const SizedBox(height: 48),
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                Column(
                  children: [
                    Text(
                      "Chaque jour, répondez à une question précise",
                      style: themeData.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: double.infinity, height: 50),
                    Text("Répondez aux questions avec honnêteté et spontanéité",
                        style: themeData.textTheme.bodyLarge, textAlign: TextAlign.center),
                    const SizedBox(width: double.infinity, height: 50),
                    Text(
                        "Vous avez 24h pour répondre à la question, vavant qu'elle disparaisse et ne revienne l'année prochaine",
                        style: themeData.textTheme.bodyLarge,
                        textAlign: TextAlign.center),
                  ],
                ),
                Column(
                  children: [
                    Text("Comme un journal intime, vos réponses vous appartiennent.",
                        style: themeData.textTheme.bodyLarge, textAlign: TextAlign.center),
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                    ),
                    Text(
                      "Répondez aux questions avec honnêteté et spontanéité.",
                      style: themeData.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                    ),
                    Text(
                      "Vous avez 24h pour répondre à la question, avant qu'elle ne disparaisse et ne revienne l'année prochaine",
                      style: themeData.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Une fois validée, vous ne pouvez pas revenir sur votre réponse.",
                        style: themeData.textTheme.bodyLarge, textAlign: TextAlign.center),
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                    ),
                    Text(
                      "Chaque jour, vous choisissez de garder vos souvenirs confidentiels ou de les partager avec vos amis.",
                      style: themeData.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      height: 50,
                    )
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(width: double.infinity, height: 50),
                    Text('365 jours\n365 questions\n365 réponses',
                        style: themeData.textTheme.bodyLarge, textAlign: TextAlign.center),
                    const SizedBox(width: double.infinity, height: 50),
                    Text(
                      "Vous êtes prêt ?",
                      style: themeData.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 24,
            children: dots
                .asMap()
                .entries
                .map((e) => Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: _activePage == e.key ? const Color.fromRGBO(223, 133, 133, 1) : Colors.white, shape: BoxShape.circle),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),
                backgroundColor: const Color.fromRGBO(50, 72, 85, 1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0)),
              ),
              onPressed: () {
                if (_activePage == 3) {
                  context.pushRoute(const RegisterRoute());
                }

                _controller.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
              },
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Suivant",
                      style: themeData.textTheme.titleLarge?.copyWith(
                        fontSize: 42,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
              onPressed: () {
                _controller.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
              },
              child:
                  Text("Retour", style: themeData.textTheme.bodyLarge?.copyWith(decoration: TextDecoration.underline)))
        ],
      ),
    );
  }
}
