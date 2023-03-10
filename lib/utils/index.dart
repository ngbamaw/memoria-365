import 'package:intl/intl.dart';

final months = [
  "Janvier",
  "Février",
  "Mars",
  "Avril",
  "Mai",
  "Juin",
  "Juillet",
  "Août",
  "Septembre",
  "Octobre",
  "Novembre",
  "Décembre"
];

getFullDate(DateTime date) {
  return {
    "day": date.day,
    "month": months[date.month - 1],
    "year": date.year
  };
  // return "${date.day}\n ${months[date.month - 1]} ${date.year}";
}

String getDate(DateTime date) {
  return DateFormat("yyyy-MM-dd").format(date);
}