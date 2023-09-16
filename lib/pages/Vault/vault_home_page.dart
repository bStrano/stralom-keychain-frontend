import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keychain_frontend/pages/Vault/widgets/credential_card.dart';

import '../../providers/vault_provider.dart';

class VaultHomePage extends ConsumerStatefulWidget {
  const VaultHomePage({super.key});

  @override
  ConsumerState<VaultHomePage> createState() => _VaultHomePageState();
}

class _VaultHomePageState extends ConsumerState<VaultHomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(secretProvider.notifier).fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Secrets secretsContext = ref.watch(secretProvider);

    return FutureBuilder(
        future: secretsContext.futureSecrets,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.isEmpty ?? true) {
              return const Center(
                child: Text("No secrets found"),
              );
            }
            return GridView.builder(
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                crossAxisCount: width > 1580
                    ? 4
                    : width > 1180
                        ? 3
                        : width > 780
                            ? 2
                            : 1,
                mainAxisExtent: 370,
                // childAspectRatio: 1.1, DONT USE THIS when using mainAxisExtent
              ),
              padding: const EdgeInsets.all(20),
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return CredentialCard(secret: snapshot.data![index]);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
