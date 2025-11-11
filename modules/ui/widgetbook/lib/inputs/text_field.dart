import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui/ui.dart';

@widgetbook.UseCase(name: 'Playground', type: AppTextField)
Widget buildDefaultAppTextFieldUseCase(BuildContext context) {
  return AppTextField(
    hintText: context.knobs.string(label: 'hint text', initialValue: 'hint text'),
    labelText: context.knobs.string(label: 'label text', initialValue: 'label text'),
    errorText: context.knobs.boolean(label: 'has error', initialValue: false)
        ? context.knobs.string(label: 'error text', initialValue: 'error text')
        : null,
    textObscure: context.knobs.boolean(label: 'text obscure', initialValue: false),
  );
}
