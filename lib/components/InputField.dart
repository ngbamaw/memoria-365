import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    this.type,
    this.controller,
    required this.label,
    this.obscure,
    this.onSaved,
  }) : super(key: key);

  final TextInputType? type;
  final String label;
  final bool? obscure;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  InputField get _inputField => super.widget;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return TextFormField(
      controller: _inputField.controller,
      onSaved: _inputField.onSaved,
      keyboardType: _inputField.type ?? TextInputType.text,
      obscureText: _inputField.obscure ?? false,
      style: const TextStyle(color: Colors.white, fontSize: 12, height: 2),
      decoration: InputDecoration(
        label: Text(
          _inputField.label,
          style: themeData.textTheme.bodyMedium,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
