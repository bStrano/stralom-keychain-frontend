// The state of our StateNotifier should be immutable.
// We could also use packages like Freezed to help with the implementation.
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keychain_frontend/models/secret_detailed.dart';

import '../apis/vault_api.dart';
import '../models/secret_basic_info.dart';

@immutable
class Secrets {
  const Secrets(
      {required this.secrets,
      required this.futureSecrets,
      required this.secretDetails});

  final List<SecretBasicInfo> secrets;
  final Future<List<SecretBasicInfo>> futureSecrets;
  final Map<String, SecretDetailed> secretDetails;

  Secrets copyWith(
      {required List<SecretBasicInfo> secrets,
      required Future<List<SecretBasicInfo>> futureSecrets,
      required Map<String, SecretDetailed> secretDetails}) {
    return Secrets(
        secrets: secrets,
        secretDetails: secretDetails,
        futureSecrets: futureSecrets);
  }
}

// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
class SecretsNotifier extends StateNotifier<Secrets> {
  final StateNotifierProviderRef<SecretsNotifier, Secrets?> ref;

  // We initialize the list of todos to an empty list
  SecretsNotifier(this.ref)
      : super(Secrets(
            secrets: const [],
            secretDetails: const {},
            futureSecrets: Future.value([])));

  // Let's allow the UI to add todos.
  void fetchAll() async {
    print('Fetching all secrets');
    final Future<List<SecretBasicInfo>> futureSecrets = VaultApi.findAll();
    final List<SecretBasicInfo> secrets = await futureSecrets;

    print(secrets);
    state = state.copyWith(
        secrets: secrets,
        futureSecrets: futureSecrets,
        secretDetails: state.secretDetails);
  }

  Future<SecretDetailed?> getDetail(String id) async {
    if (!state.secretDetails.containsKey(id)) {
      final vault = await VaultApi.findDetail(id);
      state = state.copyWith(
          secrets: state.secrets,
          futureSecrets: state.futureSecrets,
          secretDetails: {...state.secretDetails, id: vault});
    }
    return state.secretDetails[id];
  }
}

final secretProvider = StateNotifierProvider<SecretsNotifier, Secrets>((ref) {
  return SecretsNotifier(ref);
});
