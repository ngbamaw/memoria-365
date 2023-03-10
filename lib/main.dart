import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:memoria/app_router.gr.dart';
import 'package:memoria/route_guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  const supabaseUrl = "https://qivjqtevaoogrnqgnrdb.supabase.co";
  const supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFpdmpxdGV2YW9vZ3JucWducmRiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzA2Njk2MzQsImV4cCI6MTk4NjI0NTYzNH0.2nQRnmagLjd7_P7rKJ9YaFm-Rqini5RZ-ddebaulH5g";

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter(authGuard: AuthGuard());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        textTheme: const TextTheme(
            bodyLarge: TextStyle(fontFamily: "Acumin", color: Colors.white, fontSize: 16),
            bodyMedium: TextStyle(fontFamily: "Acumin", color: Colors.white, fontSize: 12),
            titleLarge: TextStyle(fontFamily: "Cartis Beatyful", color: Colors.white, fontSize: 32)),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/first-screen.jpeg"),
        fit: BoxFit.cover,
      )),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.7),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "365",
              style: TextStyle(
                  fontSize: 80, fontFamily: "Cartis Beatyful", color: Colors.white, decoration: TextDecoration.none),
            ),
            Text(
              "Memoria",
              style: TextStyle(
                height: 0.5,
                fontSize: 70,
                fontFamily: "Cartis Beatyful",
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}
