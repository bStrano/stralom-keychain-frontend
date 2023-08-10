import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:keychain_frontend/models/shareable_secret.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/config.dart';

class ShareableSecretFeedback extends StatefulWidget {
  final ShareableSecret shareableSecret;
  final Function onSuccess;

  const ShareableSecretFeedback(
      {super.key, required this.shareableSecret, required this.onSuccess});

  @override
  State<ShareableSecretFeedback> createState() =>
      _ShareableSecretFeedbackState();
}

class _ShareableSecretFeedbackState extends State<ShareableSecretFeedback>
    with TickerProviderStateMixin {
  bool animationFinished = false;
  String get url => '${Config.url}/#/detail/${widget.shareableSecret.id}';
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  void onSuccess() {
    widget.onSuccess();
  }

  void onCopy() {
    Clipboard.setData(ClipboardData(text: url)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.copyClipboard)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: !animationFinished
            ? Center(
                child: Column(
                  children: [
                    Lottie.asset('assets/animations/lock-animation.json',
                        onLoaded: (composition) {
                      // Configure the AnimationController with the duration of the
                      // Lottie file and start the animation.
                      _lottieController.duration = composition.duration;
                      _lottieController.forward().whenComplete(
                          () => setState(() => animationFinished = true));
                    }),
                    Text(
                        AppLocalizations.of(context)!
                            .shareableSecretRegisterLoadingMessage,
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              )
            : (Center(
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the left

                        children: [
                          Text(
                              AppLocalizations.of(context)!
                                  .shareableSecretFeedbackTitle,
                              style: Theme.of(context).textTheme.headlineLarge),
                          const SizedBox(height: 20),
                          Text(
                              AppLocalizations.of(context)!
                                  .shareableSecretFeedbackLifetime(
                                      DateFormat.yMMMEd().format(widget
                                          .shareableSecret.expirationDate),
                                      AppLocalizations.of(context)!
                                          .nVisualizations(widget
                                              .shareableSecret.maxViewCount)),
                              style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 50),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: TextFormField(
                                    initialValue: url,
                                    enabled: true,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(),
                                      labelText: AppLocalizations.of(context)!
                                          .shareableSecret,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.content_copy),
                                onPressed: onCopy,
                              ),
                            ],
                          ),
                          widget.shareableSecret.password != null &&
                                  widget.shareableSecret.password != ''
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start, // Align text to the left
                                  children: [
                                    const SizedBox(height: 40),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .shareableSecretFeedbackPasswordTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                        initialValue:
                                            widget.shareableSecret.password,
                                        enabled: true,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(),
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .password,
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .surface)),
                                    const SizedBox(height: 40),
                                    const Divider(),
                                  ],
                                )
                              : Container(),
                          const SizedBox(height: 40),
                          Row(children: [
                            Expanded(
                              child: OutlinedButton(
                                  onPressed: () {},
                                  child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(AppLocalizations.of(context)!
                                          .shareableSecretFeedbackCreateAnother(
                                              '✉️')))),
                            )
                          ]),
                          const SizedBox(height: 20),
                          Row(children: [
                            Expanded(
                              child: OutlinedButton(
                                  onPressed: () {
                                    onSuccess();
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                          AppLocalizations.of(context)!
                                              .shareableSecretFeedbackCreateAnother(
                                                  '♻'),
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface)))),
                            )
                          ]),
                          const SizedBox(width: 20),
                        ])))));
  }
}
