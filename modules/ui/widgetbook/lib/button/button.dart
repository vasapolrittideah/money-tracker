import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui/ui.dart';

@widgetbook.UseCase(name: 'Default', type: AppButton)
Widget buildButtonUseCase(BuildContext context) {
  return AppButton(
    text: 'การทดลองสิ่งมหัศจรรย์',
    isBlock: context.knobs.boolean(label: 'Block'),
    variant: context.knobs.list(
      label: 'Variant',
      options: AppButtonVariant.values,
      initialOption: AppButtonVariant.primary,
    ),
    mode: context.knobs.list(
      label: 'Mode',
      options: AppButtonMode.values,
      initialOption: AppButtonMode.filled,
    ),
    size: context.knobs.list(
      label: 'Size',
      options: AppButtonSize.values,
      initialOption: AppButtonSize.md,
    ),
  );
}
