import 'package:shared/libs.dart';
import 'package:shared/shared.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<SessionModel>(), AdapterSpec<LocaleModel>()])
class HiveAdapters {}
