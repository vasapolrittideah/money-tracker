import 'package:flutter/material.dart';
import 'package:shared/libs.dart';

class TransitionUtil {
  static CustomTransitionPage<T> slideTransitionPage<T>({
    required Widget child,
    required GoRouterState state,
    AxisDirection direction = AxisDirection.up,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        final tween = Tween<Offset>(
          begin: _getOffsetFromDirection(direction),
          end: Offset.zero,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  static Offset _getOffsetFromDirection(AxisDirection direction) {
    return switch (direction) {
      AxisDirection.up => const Offset(0, 1),
      AxisDirection.down => const Offset(0, -1),
      AxisDirection.left => const Offset(1, 0),
      AxisDirection.right => const Offset(-1, 0),
    };
  }
}
