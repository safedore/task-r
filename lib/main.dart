import 'package:task_mgmt/app/app.dart';
import 'package:task_mgmt/app/injector/injector.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}
