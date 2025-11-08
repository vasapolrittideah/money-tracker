import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  LicenseRegistry.addLicense(() async* {
    final fontPath = 'assets/fonts/ibm_plex_sans_thai';
    final license = await rootBundle.loadString('$fontPath/OFL.txt');
    yield LicenseEntryWithLineBreaks(<String>[fontPath], license);
  });
}
