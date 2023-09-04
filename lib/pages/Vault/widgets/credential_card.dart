import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keychain_frontend/models/secret_basic_info.dart';

import '../../../widgets/copyable_input.dart';

class CredentialCard extends StatefulWidget {
  final SecretBasicInfo secret;
  const CredentialCard({super.key, required this.secret});

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.key_sharp),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.secret.title),
                    Text(widget.secret.description != null
                        ? widget.secret.description!
                        : ''),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            CopyableInput(
              label: AppLocalizations.of(context)!.username,
              value: widget.secret.userName,
            ),
            const SizedBox(height: 20),
            CopyableInput(
                label: AppLocalizations.of(context)!.password,
                value: '******************************',
                hidable: true),
          ],
        ),
      ),
    );
  }
}
