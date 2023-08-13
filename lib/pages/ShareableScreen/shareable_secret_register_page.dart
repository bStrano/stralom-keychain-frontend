import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keychain_frontend/pages/ShareableScreen/widgets/shareable_secret_feedback.dart';

import '../../apis/shareable_secret_api.dart';
import '../../enum/lifetime_enum.dart';
import '../../models/register_shareable_secret.dart';
import '../../models/shareable_secret.dart';

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
  late ShareableSecret _shareableSecretFeedback;

  final _formKey = GlobalKey<FormState>();

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _shareSecret() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ShareableSecret shareableSecret =
          await ShareableSecretApi.registerShareableSecret(
              RegisterShareableSecret(
                  _secret, _lifetime, _maxViewCount, _secretPassword));
      setState(() {
        showFeedback = true;
        _shareableSecretFeedback = shareableSecret;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth = 800;

    final List<DropdownMenuItem<LifetimeEnum>> lifetimeEntries = [
      DropdownMenuItem<LifetimeEnum>(
          value: LifetimeEnum.oneDay,
          child: Text(AppLocalizations.of(context)!.nDays(1))),
      DropdownMenuItem<LifetimeEnum>(
          value: LifetimeEnum.twoDays,
          child: Text(AppLocalizations.of(context)!.nDays(2))),
      DropdownMenuItem<LifetimeEnum>(
          value: LifetimeEnum.threeDays,
          child: Text(AppLocalizations.of(context)!.nDays(3))),
      DropdownMenuItem<LifetimeEnum>(
          value: LifetimeEnum.oneWeek,
          child: Text(AppLocalizations.of(context)!.nWeeks(1))),
      DropdownMenuItem<LifetimeEnum>(
          value: LifetimeEnum.twoWeeks,
          child: Text(AppLocalizations.of(context)!.nWeeks(2))),
      DropdownMenuItem<LifetimeEnum>(
          value: LifetimeEnum.oneMonth,
          child: Text(AppLocalizations.of(context)!.nMonths(1))),
      DropdownMenuItem<LifetimeEnum>(
          value: LifetimeEnum.threeMonths,
          child: Text(AppLocalizations.of(context)!.nMonths(3))),
      DropdownMenuItem<LifetimeEnum>(
          value: LifetimeEnum.oneYear,
          child: Text(AppLocalizations.of(context)!.nYears(1))),
    ];

    final List<DropdownMenuItem<num>> maxViewCountEntries = [
      DropdownMenuItem<num>(
          value: 1,
          child: Text(AppLocalizations.of(context)!.nVisualizations(1))),
      DropdownMenuItem<num>(
          value: 2,
          child: Text(AppLocalizations.of(context)!.nVisualizations(2))),
      DropdownMenuItem<num>(
          value: 3,
          child: Text(AppLocalizations.of(context)!.nVisualizations(3))),
      DropdownMenuItem<num>(
          value: 5,
          child: Text(AppLocalizations.of(context)!.nVisualizations(5))),
      DropdownMenuItem<num>(
          value: 10,
          child: Text(AppLocalizations.of(context)!.nVisualizations(10))),
      DropdownMenuItem<num>(
          value: 15,
          child: Text(AppLocalizations.of(context)!.nVisualizations(15))),
      DropdownMenuItem<num>(
          value: 25,
          child: Text(AppLocalizations.of(context)!.nVisualizations(25))),
      DropdownMenuItem<num>(
          value: 50,
          child: Text(AppLocalizations.of(context)!.nVisualizations(50))),
      DropdownMenuItem<num>(
          value: 100,
          child: Text(AppLocalizations.of(context)!.nVisualizations(100))),
      DropdownMenuItem<num>(
          value: 250,
          child: Text(AppLocalizations.of(context)!.nVisualizations(250))),
      DropdownMenuItem<num>(
          value: 500,
          child: Text(AppLocalizations.of(context)!.nVisualizations(500))),
      DropdownMenuItem<num>(
          value: 1000,
          child: Text(AppLocalizations.of(context)!.nVisualizations(1000))),
    ];

    if (showFeedback) {
      return (ShareableSecretFeedback(
          onSuccess: () {
            setState(() {
              showFeedback = false;
            });
          },
          shareableSecret: _shareableSecretFeedback));
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
