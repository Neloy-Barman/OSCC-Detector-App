import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home.dart';
import './screens/detailedView.dart';
import './screens/classifierScreen.dart';
import './screens/aboutScreen.dart';

import './providers/fixState.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const OsccDetector(),
  );
}

class OsccDetector extends StatelessWidget {
  const OsccDetector({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => fixState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'Lora',
        ),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeScreen: (_) => const HomeScreen(),
          DetailedViewScreen.routeScreen: (_) => const DetailedViewScreen(),
          ClassifierScreen.routeScreen: (_) => const ClassifierScreen(),
          AboutScreen.routeScreen: (_) => const AboutScreen(),
        },
      ),
    );
  }
}
