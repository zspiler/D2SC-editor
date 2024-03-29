import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class MyColorPicker extends StatelessWidget {
  final Color color;
  final Function(Color) onChange;

  const MyColorPicker({
    Key? key,
    required this.color,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorIndicator(
      width: 40,
      height: 40,
      borderRadius: 4,
      color: color,
      onSelectFocus: false,
      onSelect: () async {
        final Color colorBeforeDialog = color;
        if (!(await _colorPickerDialog(context: context, color: color, onChange: onChange))) {
          onChange(colorBeforeDialog);
        }
      },
    );
  }

  Future<bool> _colorPickerDialog({
    required BuildContext context,
    required Color color,
    required Function(Color) onChange,
  }) async {
    return ColorPicker(
      color: color,
      onColorChanged: onChange,
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      padding: const EdgeInsets.all(32),
      wheelDiameter: 200,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
        ColorPickerType.accent: false,
        ColorPickerType.both: false,
        ColorPickerType.bw: false,
        ColorPickerType.primary: false,
        ColorPickerType.custom: false,
      },
      enableShadesSelection: false,
    ).showPickerDialog(
      context,
      transitionBuilder: (BuildContext context, Animation<double> a1, Animation<double> a2, Widget widget) {
        final double curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints: const BoxConstraints(minHeight: 350, minWidth: 300, maxWidth: 320),
    );
  }
}
