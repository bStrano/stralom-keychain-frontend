import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keychain_frontend/apis/vault_api.dart';
import 'package:keychain_frontend/models/register_secret.dart';

import '../../../providers/vault_provider.dart';

class VaultRegisterDialog extends ConsumerStatefulWidget {
  const VaultRegisterDialog({super.key});

  @override
  ConsumerState<VaultRegisterDialog> createState() =>
      _VaultRegisterDialogState();
}

class _VaultRegisterDialogState extends ConsumerState<VaultRegisterDialog> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _title = '';
  String _username = '';
  String _encryptionPassword = '';
  String? _subtitle;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await VaultApi.register(RegisterSecret(
          _username, _password, _title, _subtitle, _encryptionPassword));
      Navigator.pop(context);
      ref.read(secretProvider.notifier).fetchAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
            child: Text(AppLocalizations.of(context)!.save),
            onPressed: () async {
              _register();
            })
      ],
      title: Text(AppLocalizations.of(context)!.vaultSecretRegisterTitle),
      content: SizedBox(
          width: 500,
          height: 450,
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onSaved: (value) {
                      _title = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.validatorNotEmpty;
                      } else if (value.length > 1000) {
                        return AppLocalizations.of(context)!
                            .validatorMinLength(1000);
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.title,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    onSaved: (value) {
                      _subtitle = value!;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.subtitle,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    onSaved: (value) {
                      _username = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.validatorNotEmpty;
                      } else if (value.length > 1000) {
                        return AppLocalizations.of(context)!
                            .validatorMinLength(1000);
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.username,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    onSaved: (value) {
                      _password = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.validatorNotEmpty;
                      } else if (value.length > 1000) {
                        return AppLocalizations.of(context)!
                            .validatorMinLength(1000);
                      }

                      return null;
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.password,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    onSaved: (value) {
                      _encryptionPassword = value!;
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText:
                          AppLocalizations.of(context)!.encryptionPassword,
                    ),
                  )
                ],
              ))),
    );
  }
}
