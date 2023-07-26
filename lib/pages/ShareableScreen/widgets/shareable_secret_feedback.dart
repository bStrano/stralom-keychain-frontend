import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class ShareableSecretFeedback extends StatefulWidget {
  const ShareableSecretFeedback({super.key});

  @override
  State<ShareableSecretFeedback> createState() =>
      _ShareableSecretFeedbackState();
}

class _ShareableSecretFeedbackState extends State<ShareableSecretFeedback>
    with TickerProviderStateMixin {
  bool animationFinished = false;
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
                                      '1 view', '1 day'),
                              style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 50),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: TextFormField(
                                    initialValue:
                                        'https://stralom.com/secret/1234567890',
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
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Text(
                              AppLocalizations.of(context)!
                                  .shareableSecretFeedbackPasswordTitle,
                              style: Theme.of(context).textTheme.titleSmall),
                          const SizedBox(height: 20),
                          TextFormField(
                              initialValue: '2324@#Senha',
                              enabled: true,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText:
                                      AppLocalizations.of(context)!.password,
                                  fillColor:
                                      Theme.of(context).colorScheme.surface)),
                          const SizedBox(height: 40),
                          const Divider(),
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
                                  onPressed: () {},
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
