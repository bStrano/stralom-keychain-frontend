import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../widgets/copyable_input.dart';

class CredentialCard extends StatefulWidget {
  const CredentialCard({super.key});

  @override
  State<CredentialCard> createState() => _CredentialCardState();
}

class _CredentialCardState extends State<CredentialCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.key_sharp),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Google'),
                    Text('https://www.google.com'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            CopyableInput(
              label: AppLocalizations.of(context)!.username,
              value: 'Usuario',
            ),
            const SizedBox(height: 20),
            CopyableInput(
                label: AppLocalizations.of(context)!.password,
                value: 'Senha',
                hidable: true),
          ],
        ),
      ),
    );
  }
}
