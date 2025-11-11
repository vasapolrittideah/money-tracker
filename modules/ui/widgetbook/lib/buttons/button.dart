import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui/ui.dart';

@widgetbook.UseCase(name: 'Playground', type: AppButton)
Widget buildDefaultAppButtonUseCase(BuildContext context) {
  return AppButton(
    text: 'This is a button',
    size: context.knobs.object.segmented(
      label: 'size',
      labelBuilder: (value) => value.name,
      options: AppButtonSize.values,
      initialOption: AppButtonSize.sm,
    ),
    variant: context.knobs.object.segmented(
      label: 'variant',
      labelBuilder: (value) => value.name,
      options: AppButtonVariant.values,
      initialOption: AppButtonVariant.primary,
    ),
    mode: context.knobs.object.segmented(
      label: 'mode',
      labelBuilder: (value) => value.name,
      options: AppButtonMode.values,
      initialOption: AppButtonMode.filled,
    ),
    fullWidth: context.knobs.boolean(label: 'fullWidth', initialValue: false),
    disabled: context.knobs.boolean(label: 'disabled', initialValue: false),
    onTap: () => debugPrint('AppButton tapped'),
  );
}
