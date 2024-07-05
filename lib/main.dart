import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurants_task/features/home/presentation/pages/home_page.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'routes.dart';
import 'style/theme.dart';

enum Env {
  DEV,
  STAGE,
  PROD,
}

//Don't forget to change this before release
const currentEnv = Env.DEV;

const isDev = identical(currentEnv, Env.DEV);
const isStage = identical(currentEnv, Env.STAGE);
const isProd = identical(currentEnv, Env.PROD);

const inspectorEnabled = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const RequestsInspector(
      enabled: inspectorEnabled,
      showInspectorOn: ShowInspectorOn.Both,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Restaurants Task',
      routes: routes,
    );
  }
}
