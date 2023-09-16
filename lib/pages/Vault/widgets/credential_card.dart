import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keychain_frontend/models/secret_basic_info.dart';
import 'package:keychain_frontend/models/secret_detailed.dart';

import '../../../providers/vault_provider.dart';
import '../../../widgets/copyable_input.dart';

class CredentialCard extends ConsumerStatefulWidget {
  final SecretBasicInfo secret;
  const CredentialCard({super.key, required this.secret});

  @override
  ConsumerState<CredentialCard> createState() => _CredentialCardState();
}

class _CredentialCardState extends ConsumerState<CredentialCard> {
  bool _loaded = false;
  String _password = '******************************';

  load() async {
    if (_loaded) return;
    print('Loading password');
    SecretDetailed? detailed =
        await ref.read(secretProvider.notifier).getDetail(widget.secret.id);

    print(detailed);
    setState(() {
      _loaded = true;
      _password = detailed!.password;
    });
  }

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
                value: _password,
                hidable: true,
                onLoad: load)
          ],
        ),
      ),
    );
  }
}
