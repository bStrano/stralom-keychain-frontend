import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/ShareableScreen/shareable_secret_page.dart';
import '../pages/ShareableScreen/shareable_secret_register_page.dart';
import '../pages/Vault/vault_home_page.dart';
import '../pages/Vault/widgets/vault_register_dialog.dart';
import '../pages/login_page.dart';
import '../providers/session_provider.dart';
import '../widgets/DefaultAppBar.dart';

const whitelist = ['/login', '/detail/'];
final Provider<GoRouter> routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const MyHomePage(title: 'Stralom Keychain'),
      redirect: (context, state) {
        for (var element in whitelist) {
          if (state.uri.toString().contains(element)) {
            return null;
          }
        }

        if (ref.read(sessionProvider.notifier).state != null) {
          return '/vault';
        }
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
          builder: (context, state) => Scaffold(
              body: const VaultHomePage(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          const VaultRegisterDialog());
                },
                tooltip: 'Add new secret',
                child: const Icon(Icons.add),
              ),
              appBar: const DefaultAppBar(
                title: 'Stralom Keychain',
              )),
        ),
      ],
    ),
  ]);
}, dependencies: [sessionProvider]);

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
