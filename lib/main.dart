import 'package:flutter/material.dart';
import 'package:plexus_task/app.dart';
import 'package:plexus_task/core/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();

  runApp(const PlexusTask());
}
