import 'package:flutter/material.dart';

import 'app.dart';
import 'injection/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const TekrarApp());
}
