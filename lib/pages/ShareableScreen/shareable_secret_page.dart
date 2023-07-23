import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../apis/shareable_secret_api.dart';
import '../../enum/lifetime_enum.dart';

class ShareableSecretPage extends StatefulWidget {
  const ShareableSecretPage({super.key});

  @override
  State<ShareableSecretPage> createState() => _ShareableSecretPageState();
}

class _ShareableSecretPageState extends State<ShareableSecretPage> {
  bool isExpanded = false;
  num maxViewCount = 1;
  LifetimeEnum lifetimeEnum = LifetimeEnum.oneDay;

  void _toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // Align text to the left
                      children: [
                        TextField(
                          maxLines: 5,
                          maxLength: 1000,
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
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .shareableSecretLifetimeInputPlaceholder,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                )),
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                  ),
                                  child: DropdownButton<num>(
                                    underline: Container(),
                                    focusColor: Colors.transparent,
                                    isExpanded: true,
                                    value: maxViewCount,
                                    onChanged: (num? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          maxViewCount = newValue;
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
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                  ),
                                  child: DropdownButton<LifetimeEnum>(
                                    underline: Container(),
                                    focusColor: Colors.transparent,
                                    isExpanded: true,
                                    value: lifetimeEnum,
                                    onChanged: (LifetimeEnum? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          lifetimeEnum = newValue;
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
                            child: TextField(
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
                              onPressed: () {},
                              child: Text(AppLocalizations.of(context)!
                                  .shareableSecretSubmit
                                  .toUpperCase()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
