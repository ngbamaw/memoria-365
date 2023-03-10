import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/components/SelectableElement.dart';

class SubscriptionSelector extends StatelessWidget {
  const SubscriptionSelector({
    Key? key,
    required this.onTap,
    this.selected,
    required this.primaryText,
    this.secondaryText,
    this.annotation,
  }) : super(key: key);

  final bool? selected;
  final String primaryText;
  final String? secondaryText;
  final String? annotation;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return SelectableElement(
        selected: selected,
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(primaryText, style: themeData.textTheme.titleLarge),
                Text(annotation ?? "", style: themeData.textTheme.bodyMedium),
              ],
            ),
            Text(secondaryText ?? "", style: themeData.textTheme.bodyMedium),
          ],
        ));
  }
}

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

enum SubscriptionType { free, premiumMonthly, premiumYearly, premiumLifetime }

class _SubscriptionPageState extends State<SubscriptionPage> {
  SubscriptionType _selected = SubscriptionType.premiumMonthly;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    bool isFree = _selected == SubscriptionType.free;
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/fond-clair.jpg'), fit: BoxFit.cover)),
        child: Column(children: [
          Text("Selectionnez votre abonnement", style: themeData.textTheme.titleLarge, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text("avec publicité", style: themeData.textTheme.bodyMedium),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          SubscriptionSelector(
              selected: isFree,
              onTap: () {
                setState(() {
                  _selected = SubscriptionType.free;
                });
              },
              primaryText: "Gratuit",
              secondaryText: "0,00€ (changer à tout moment)"),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text("sans publicité", style: themeData.textTheme.bodyMedium),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          SubscriptionSelector(
              selected: _selected == SubscriptionType.premiumMonthly,
              onTap: () {
                setState(() {
                  _selected = SubscriptionType.premiumMonthly;
                });
              },
              primaryText: "Mensuel",
              secondaryText: "2,99€ / mois (changer ou annuler à tout moment)"),
          const SizedBox(height: 12),
          SubscriptionSelector(
              selected: _selected == SubscriptionType.premiumYearly,
              onTap: () {
                setState(() {
                  _selected = SubscriptionType.premiumYearly;
                });
              },
              primaryText: "Annuel",
              secondaryText: "19,99€ / an (changer ou annuler à tout moment)"),
          const SizedBox(height: 12),
          SubscriptionSelector(
              selected: _selected == SubscriptionType.premiumLifetime,
              onTap: () {
                setState(() {
                  _selected = SubscriptionType.premiumLifetime;
                });
              },
              primaryText: "À vie",
              secondaryText: "24,99€ paiement unique"),
          const Spacer(),
          SizedBox(
            height: 78,
            width: double.infinity,
            child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: isFree ? 48 : 12, vertical: 24),
                  backgroundColor: const Color.fromRGBO(50, 72, 85, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48.0)),
                ),
                onPressed: () {
                  if(isFree) {
                    context.router.push(const DailyQuestionRoute());
                  }
                },
                child: Text(
                  isFree ? "Commencer" : "Commencer l'essai gratuit de 3 jours",
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontSize: isFree ? 36 : 24,
                  ),
                  textAlign: TextAlign.center,
                )),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 72,
                child: Text(
                  "Restaurer ",
                  style: themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.5)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 100,
                child: Text(
                  "Politique de confidentialité",
                  style: themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.5)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 72,
                child: Text(
                  "CGU",
                  style: themeData.textTheme.bodyMedium?.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.5)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ]));
  }
}
