import 'package:shared/src/models/session/session_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<SessionModel>()])
class HiveAdapters {}
