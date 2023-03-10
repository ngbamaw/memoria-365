import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class ResponseBlock extends StatelessWidget {
  const ResponseBlock({super.key, required this.response, this.author});

  final String response;
  final String? author;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return DottedBorder(
      color: const Color.fromRGBO(255, 255, 255, 0.3),
      strokeWidth: 2,
      dashPattern: const [4],
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (author != null) ...[Text(author!, style: themeData.textTheme.titleLarge), const SizedBox(height: 8)],
            TextField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: InputBorder.none,
                hintText: response,
                hintStyle: const TextStyle(color: Colors.white),
                counter: const SizedBox.shrink(),
              ),
              enabled: false,
              style: const TextStyle(color: Colors.white),
              maxLength: 200,
              maxLines: 8,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}
