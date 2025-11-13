import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted) {
            context.go(AuthRouteName.login);
          }
        });
      });

      return null;
    }, []);

    return Scaffold(
      backgroundColor: context.appColors.staticWhite,
      body: const SafeArea(child: Center()),
    );
  }
}
