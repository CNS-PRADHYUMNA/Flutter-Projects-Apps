import 'package:budegets_app/widgets/expences.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

var kcolorScheme = ColorScheme.fromSeed(seedColor: Colors.blueAccent);
var bbb = ColorScheme.fromSeed(
  seedColor: Colors.indigoAccent,
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: bbb,
        cardTheme: CardTheme().copyWith(
          color: bbb.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: bbb.onSecondaryContainer,
                  fontSize: 17),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: bbb.primaryContainer,
              foregroundColor: bbb.onPrimaryContainer),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorScheme,
        appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kcolorScheme.onPrimaryContainer,
            foregroundColor: kcolorScheme.onPrimary),
        cardTheme: CardTheme().copyWith(
          color: kcolorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kcolorScheme.onSecondaryContainer,
                  fontSize: 17),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kcolorScheme.primaryContainer),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const Expences(),
    );
  }
}
