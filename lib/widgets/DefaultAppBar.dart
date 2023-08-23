import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keychain_frontend/providers/session_provider.dart';

class DefaultAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;

  const DefaultAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: () {
            context.goNamed(
              'vault',
            );
          },
          child: const Text('Vault'),
        ),
        TextButton(
          onPressed: () {
            ref.read(sessionProvider.notifier).deleteSession();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
