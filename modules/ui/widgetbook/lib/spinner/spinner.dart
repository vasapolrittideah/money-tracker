import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui/ui.dart';

@widgetbook.UseCase(name: 'Default', type: AppSpinner)
Widget buildSpinnerUseCase(BuildContext context) {
  return AppSpinner();
}
