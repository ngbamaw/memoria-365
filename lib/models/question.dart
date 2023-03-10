class Question {
  final int id;
  final String question;
  final DateTime date;

  Question({required this.id, required this.question, required this.date});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      date: DateTime.parse(json['date']),
    );
  }
}