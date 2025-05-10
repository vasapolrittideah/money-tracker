import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui/ui.dart';

@widgetbook.UseCase(name: 'Default', type: AppTextInput)
AppTextInput buildTextInputUseCase(BuildContext context) {
  return AppTextInput(
    hintText: 'กรุณากรอกรหัสผ่าน',
    labelText: 'รหัสผ่าน',
    errorText: context.knobs.stringOrNull(
      label: 'Error text',
      initialValue: null,
    ),
    isReadOnly: context.knobs.boolean(label: 'Read only', initialValue: false),
    isDisabled: context.knobs.boolean(label: 'Disabled', initialValue: false),
  );
}
