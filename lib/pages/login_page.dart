import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 7,
            child: Center(
                child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent,
                  Colors.black,
                ],
              )),
              child: Center(
                child: Lottie.asset('assets/animations/login.json'),
              ),
            ))),
        Flexible(
          flex: 4,
          child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Text('SL'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: AppLocalizations.of(context)!
                        .loginUsernameInputPlaceholder,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: AppLocalizations.of(context)!
                        .loginPasswordInputPlaceholder,
                  ),
                ),
                const SizedBox(height: 30),
                Row(children: [
                  Expanded(
                      child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                              AppLocalizations.of(context)!
                                  .loginButtonSubmit
                                  .toUpperCase(),
                              style: Theme.of(context).textTheme.labelLarge))),
                ]),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // use whichever suits your need
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(AppLocalizations.of(context)!
                            .loginButtonForgotPassword)),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                            AppLocalizations.of(context)!.loginButtonRegister)),
                  ],
                ),
                const SizedBox(height: 40),
                Text("Copyright © Stralom${DateTime.now().year}",
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
        )
      ],
    );
  }
}
