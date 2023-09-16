import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keychain_frontend/apis/login_api.dart';
import 'package:keychain_frontend/models/login_response.dart';
import 'package:lottie/lottie.dart';

import '../models/login_request.dart';
import '../providers/session_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _username = '';
  String? _password = '';

  void onLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      LoginResponse loginResponse = await LoginApi.login(LoginRequest(
        _username!,
        _password!,
      ));
      ref.read(sessionProvider.notifier).createSession(Session(
          id: loginResponse.id.toString(),
          userName: loginResponse.name,
          accessToken: loginResponse.accessToken,
          refreshToken: loginResponse.refreshToken.code));
    }

    context.goNamed('vault');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Row(
        children: [
          width > 900
              ? Flexible(
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
                  )))
              : Container(),
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context)!
                          .loginUsernameInputPlaceholder,
                    ),
                    onSaved: (String? value) {
                      _username = value;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.validatorNotEmpty;
                      } else if (value.length > 1000) {
                        return AppLocalizations.of(context)!
                            .validatorMinLength(1000);
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context)!
                          .loginPasswordInputPlaceholder,
                    ),
                    onSaved: (String? value) {
                      _password = value;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.validatorNotEmpty;
                      } else if (value.length > 1000) {
                        return AppLocalizations.of(context)!
                            .validatorMinLength(1000);
                      }

                      return null;
                    },
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
                            onPressed: () {
                              onLogin(context);
                            },
                            child: Text(
                                AppLocalizations.of(context)!
                                    .loginButtonSubmit
                                    .toUpperCase(),
                                style:
                                    Theme.of(context).textTheme.labelLarge))),
                  ]),
                  const SizedBox(height: 10),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment
                  //       .spaceBetween, // use whichever suits your need
                  //   children: [
                  //     TextButton(
                  //         onPressed: () {},
                  //         child: Text(AppLocalizations.of(context)!
                  //             .loginButtonForgotPassword)),
                  //     TextButton(
                  //         onPressed: () {},
                  //         child: Text(AppLocalizations.of(context)!
                  //             .loginButtonRegister)),
                  //   ],
                  // ),
                  const SizedBox(height: 40),
                  Text("Copyright © Stralom${DateTime.now().year}",
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
