class Response {
  final String text;
  bool private;
  final String date;

  Response({required this.text, required this.date, required this.private});

  @override
  String toString() {
    return "Response: $text, $date, $private";
  }

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      text: json['text'],
      date: json['date'],
      private: json['private'],
    );
  }
}