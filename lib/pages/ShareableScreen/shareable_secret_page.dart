import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShareableSecretDetailPage extends StatefulWidget {
  final String secretId;
  const ShareableSecretDetailPage({super.key, required this.secretId});

  @override
  State<ShareableSecretDetailPage> createState() =>
      _ShareableSecretDetailPageState();
}

class _ShareableSecretDetailPageState extends State<ShareableSecretDetailPage> {
  bool _secretRevealed = false;
  final TextEditingController _controller =
      TextEditingController(text: '*****************************');

  void _revealSecret() {
    setState(() {
      _secretRevealed = true;
    });
    _controller.value = _controller.value.copyWith(text: "SECRET SECRET VALUE");
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: 800,
        margin: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the left
          children: [
            Text(AppLocalizations.of(context)!.shareableSecretDetailsTitle,
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 10),
            Text(AppLocalizations.of(context)!
                .shareableSecretDetailsSubtitle(1)),
            const SizedBox(height: 30),
            TextFormField(
                enabled: true,
                readOnly: true,
                controller: _controller,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.shareableSecret,
                    fillColor: Theme.of(context).colorScheme.surface)),
            const SizedBox(height: 30),
            !_secretRevealed
                ? TextField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.password,
                        fillColor: Theme.of(context).colorScheme.surface))
                : Container(),
            const SizedBox(height: 50),
            !_secretRevealed
                ? Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: _revealSecret,
                              child: Text(AppLocalizations.of(context)!
                                  .shareableSecretDetailsRevealButton
                                  .toUpperCase()))),
                    ],
                  )
                : Container(),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!
                      .shareableSecretDetailsCreateAnotherButton,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Theme.of(context).colorScheme.outline),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
