import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../firebase_options.dart';
import '../../app/core/helpers/environments.dart';


class ApplicationConfig {
  Future<void> configureApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _firebaseCoreConfig();
    await _loadEvns();
  }

  Future<void> _firebaseCoreConfig() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  
   Future<void> _loadEvns() => Environments.loadEvns();
}
