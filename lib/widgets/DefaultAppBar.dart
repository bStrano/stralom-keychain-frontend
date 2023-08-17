import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const DefaultAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
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
        const TextButton(
          onPressed: null,
          child: Text('Sing up'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
