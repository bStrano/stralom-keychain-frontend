import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:keychain_frontend/models/shareable_secret.dart';
import 'package:keychain_frontend/models/shareable_secret_metadata.dart';
import 'package:lottie/lottie.dart';

import '../../apis/shareable_secret_api.dart';

class ShareableSecretDetailPage extends StatefulWidget {
  final String secretId;
  const ShareableSecretDetailPage({super.key, required this.secretId});

  @override
  State<ShareableSecretDetailPage> createState() =>
      _ShareableSecretDetailPageState();
}

class _ShareableSecretDetailPageState extends State<ShareableSecretDetailPage> {
  bool _secretRevealed = false;
  ShareableSecretMetadata? _shareableSecret;
  final TextEditingController _controller =
      TextEditingController(text: "***************************");
  late Future<ShareableSecretMetadata> _futureShareableSecret;

  Future<ShareableSecretMetadata> fetchMetadata() async {
    final ShareableSecretMetadata shareableSecret =
        await ShareableSecretApi.getShareableSecretMetadata(widget.secretId);
    setState(() {
      _shareableSecret = shareableSecret;
    });
    return shareableSecret;
  }

  @override
  void initState() {
    super.initState();
    _futureShareableSecret = fetchMetadata();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _revealSecret() async {
    final ShareableSecret shareableSecret =
        await ShareableSecretApi.visualizeShareableSecret(widget.secretId);

    setState(() {
      _secretRevealed = true;
    });

    _controller.value =
        _controller.value.copyWith(text: shareableSecret.secret);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ShareableSecretMetadata>(
      future: _futureShareableSecret,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (Align(
            child: Container(
              width: 800,
              margin: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                      AppLocalizations.of(context)!.shareableSecretDetailsTitle,
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!
                      .shareableSecretDetailsSubtitle(
                          _shareableSecret!.remainingViews)),
                  const SizedBox(height: 30),
                  TextFormField(
                      enabled: true,
                      readOnly: true,
                      controller: _controller,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText:
                              AppLocalizations.of(context)!.shareableSecret,
                          fillColor: Theme.of(context).colorScheme.surface)),
                  const SizedBox(height: 30),
                  !_secretRevealed && _shareableSecret?.hasPassword == true
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
                            .copyWith(
                                color: Theme.of(context).colorScheme.outline),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
        } else if (snapshot.hasError) {
          return Center(
              child: (Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations/empty.json'),
              Text(
                  AppLocalizations.of(context)!
                      .shareableSecretDetailsNotFoundTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Theme.of(context).highlightColor)),
              const SizedBox(height: 10),
              Text(
                  AppLocalizations.of(context)!
                      .shareableSecretDetailsNotFoundSubtitle,
                  style: Theme.of(context).textTheme.titleMedium)
            ],
          )));
        }

        // By default, show a loading spinner.
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
