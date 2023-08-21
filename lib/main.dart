import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keychain_frontend/pages/ShareableScreen/shareable_secret_page.dart';
import 'package:keychain_frontend/pages/ShareableScreen/shareable_secret_register_page.dart';
import 'package:keychain_frontend/pages/Vault/vault_home_page.dart';
import 'package:keychain_frontend/pages/login_page.dart';
import 'package:keychain_frontend/widgets/DefaultAppBar.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const MyHomePage(title: 'Stralom Keychain'),
      redirect: (context, state) {
        return '/login';
      },
      routes: [
        GoRoute(
          path: 'detail/:id',
          builder: (_, state) => Scaffold(
              body: ShareableSecretDetailPage(
                secretId: state.pathParameters['id']!,
              ),
              appBar: const DefaultAppBar(
                title: 'Stralom Keychain',
              )),
        ),
        // TODO: Temp
        GoRoute(
          name: 'login',
          path: 'login',
          builder: (_, state) => const Scaffold(
              body: LoginPage(),
              appBar: DefaultAppBar(
                title: 'Stralom Keychain',
              )),
        ),
        GoRoute(
          name: 'vault',
          path: 'vault',
          builder: (_, state) => const Scaffold(
              body: VaultHomePage(),
              appBar: DefaultAppBar(
                title: 'Stralom Keychain',
              )),
        )
      ],
    ),
  ],
);

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
  seedColor: const Color.fromRGBO(255, 0, 131, 1),
  brightness: Brightness.dark,
  primary: const Color.fromRGBO(255, 0, 131, 1),
  surface: const Color.fromRGBO(21, 28, 36, 1),
  background: const Color.fromRGBO(27, 36, 46, 1),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Stralom Keychain',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
        highlightColor: const Color.fromRGBO(255, 0, 131, 1),
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
      appBar: DefaultAppBar(
        title: widget.title,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.only(top: 50),
        child: const ShareableSecretPage(),
      ),
    );
  }
}
