import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class SelectableElement extends StatefulWidget {
  const SelectableElement({
    Key? key,
    required this.child,
    required this.onTap,
    this.selected,
  }) : super(key: key);

  final Widget child;
  final bool? selected;
  final Function()? onTap;

  @override
  State<SelectableElement> createState() => _SelectableElementState();
}

class _SelectableElementState extends State<SelectableElement> {
  SelectableElement get _selectableElement => super.widget;

  @override
  Widget build(BuildContext context) {
    bool selected = _selectableElement.selected ?? false;
    double opacityContainer = !selected ? 0 : 1;
    double opacityDottedBorder = !selected ? 0.5 : 0;

    return GestureDetector(
        onTap: _selectableElement.onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(28)),
            border: Border.fromBorderSide(BorderSide(color: Color.fromRGBO(255, 255, 255, opacityContainer), width: 4)),
          ),
          child: DottedBorder(
            color: Color.fromRGBO(255, 255, 255, opacityDottedBorder),
            strokeWidth: 2,
            dashPattern: const [4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(28),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: _selectableElement.child,
          ),
        ));
  }
}
