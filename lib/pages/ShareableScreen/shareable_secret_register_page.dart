import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keychain_frontend/pages/ShareableScreen/widgets/shareable_secret_feedback.dart';

import '../../apis/shareable_secret_api.dart';
import '../../enum/lifetime_enum.dart';

class ShareableSecretPage extends StatefulWidget {
  const ShareableSecretPage({super.key});

  @override
  State<ShareableSecretPage> createState() => _ShareableSecretPageState();
}

class _ShareableSecretPageState extends State<ShareableSecretPage> {
  String _secret = '';
  bool isExpanded = false;
  num _maxViewCount = 1;
  LifetimeEnum _lifetime = LifetimeEnum.oneDay;
  String? _secretPassword;

  bool showFeedback = false;

  final _formKey = GlobalKey<FormState>();

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _shareSecret() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // ShareableSecretApi.registerShareableSecret(RegisterShareableSecret(
      //     _secret, _lifetime, _maxViewCount, _secretPassword));
      setState(() {
        showFeedback = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = 800;

    final List<DropdownMenuItem<LifetimeEnum>> lifetimeEntries =
        ShareableSecretApi.getLifetimeOptions()
            .map((item) => DropdownMenuItem<LifetimeEnum>(
                value: item['value'], child: Text(item['label'])))
            .toList();
    final List<DropdownMenuItem<num>> maxViewCountEntries =
        ShareableSecretApi.getViewCountOptions()
            .map((item) => DropdownMenuItem<num>(
                  value: item['value'],
                  child: Text(item['label']),
                ))
            .toList();

    if (showFeedback) {
      return (const ShareableSecretFeedback());
    }
    return (Align(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: [
          Text(
            AppLocalizations.of(context)!.shareSecret,
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Theme.of(context).highlightColor),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              AppLocalizations.of(context)!.shareSecretDescription,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          Card(
              child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: SizedBox(
                      width: cardWidth,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Align text to the left
                          children: [
                            TextFormField(
                              maxLines: 5,
                              maxLength: 1000,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .validatorNotEmpty;
                                } else if (value.length > 1000) {
                                  return AppLocalizations.of(context)!
                                      .validatorMinLength(1000);
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _secret = value!;
                              },
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: AppLocalizations.of(context)!
                                    .shareableSecretInputPlaceholder,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // Align text to the left
                              children: [
                                Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .shareableSecretLifetimeInputPlaceholder,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    )),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: DropdownButtonFormField<num>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        focusColor: Colors.transparent,
                                        isExpanded: true,
                                        value: _maxViewCount,
                                        onChanged: (num? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              _maxViewCount = newValue;
                                            });
                                          }
                                        },
                                        items: maxViewCountEntries,
                                      ),
                                    )),
                                    const SizedBox(width: 30),
                                    const Text('ou'),
                                    const SizedBox(width: 30),
                                    Expanded(
                                        child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child:
                                          DropdownButtonFormField<LifetimeEnum>(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        focusColor: Colors.transparent,
                                        isExpanded: true,
                                        value: _lifetime,
                                        onChanged: (LifetimeEnum? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              _lifetime = newValue;
                                            });
                                          }
                                        },
                                        items: lifetimeEntries,
                                      ),
                                    )),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 30),
                            TextButton(
                                onPressed: _toggleExpanded,
                                child: SizedBox(
                                    child: Row(children: [
                                  const Icon(Icons.add),
                                  Text(AppLocalizations.of(context)!
                                      .additionalInfo
                                      .toUpperCase()),
                                ]))),
                            if (isExpanded)
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  onSaved: (value) {
                                    _secretPassword = value!;
                                  },
                                  validator: (value) {
                                    if (value != null) {
                                      if (value.length > 1000) {
                                        return AppLocalizations.of(context)!
                                            .validatorMinLength(1000);
                                      }
                                    }
                                    return null;
                                  },
                                  maxLines: 1,
                                  maxLength: 1000,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: AppLocalizations.of(context)!
                                        .shareableSecretInputPlaceholder,
                                  ),
                                ),
                              ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _shareSecret();
                                  },
                                  child: Text(AppLocalizations.of(context)!
                                      .shareableSecretSubmit
                                      .toUpperCase()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )))),
        ],
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
