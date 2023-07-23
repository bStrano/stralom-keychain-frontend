import 'package:flutter/material.dart';
import 'package:keychain_frontend/pages/ShareableScreen/shareable_secret_page.dart';

void main() {
  runApp(const MyApp());
}

var kColorSchemeLight = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  brightness: Brightness.light,
  primary: Colors.deepPurple,
  onPrimary: Colors.white,
  // Colors that are not relevant to AppBar in LIGHT mode:
  primaryContainer: Colors.grey,
  secondary: Colors.purpleAccent,
  secondaryContainer: Colors.grey,
  onSecondary: Colors.grey,
  background: Colors.grey,
  onBackground: Colors.grey,
  surface: Colors.grey,
  onSurface: Colors.grey,
  error: Colors.grey,
  onError: Colors.grey,
);

var kColorSchemeDark = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(255, 0, 131,1),
  brightness: Brightness.dark,
  primary:  const Color.fromRGBO(255, 0, 131,1),
  surface: const Color.fromRGBO(21, 28, 36, 1),
  background: const Color.fromRGBO(27, 36, 46, 1),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stralom Keychain',
      // theme: ThemeData().copyWith(
      //   colorScheme: kColorSchemeLight,
      //   appBarTheme: const AppBarTheme().copyWith(
      //     backgroundColor: kColorSchemeLight.onPrimaryContainer,
      //     foregroundColor: kColorSchemeLight.primaryContainer,
      //     titleTextStyle: const TextStyle(
      //       color: Colors.white,
      //       fontSize: 24,
      //     ),
      //   )
      // ),
      darkTheme: ThemeData(
        fontFamily: 'Roboto',
        highlightColor: const Color.fromRGBO(255, 0, 131,1),
        colorScheme: kColorSchemeDark,
        scaffoldBackgroundColor: kColorSchemeDark.background,
        cardColor: kColorSchemeDark.surface,
        cardTheme: const CardTheme(
          elevation: 6,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorSchemeDark.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(25),
            elevation: 4,
            shadowColor: kColorSchemeDark.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: kColorSchemeDark.onSurface),
          color: kColorSchemeDark.surface,
          elevation: 0,

        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kColorSchemeDark.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // textTheme: const TextTheme().copyWith(
        //   titleLarge: TextStyle(
        //     color: Colors.white,
        //     fontSize: 24,
        //   ),
        // ),
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           title: Text(widget.title),
          actions: const [
            TextButton(
              onPressed: null,
              child: Text('Log in'),
            ),
            TextButton(
              onPressed: null,
              child: Text('Sing up'),
            ),
          ],

        ),
        body: Container(
          padding: const EdgeInsets.only(top: 50),
          child: const ShareableSecretPage(),
        ),
    );
  }
}
