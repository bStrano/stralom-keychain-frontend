import 'package:flutter/material.dart';
import 'package:keychain_frontend/models/secret_basic_info.dart';
import 'package:keychain_frontend/pages/Vault/widgets/credential_card.dart';

import '../../apis/vault_api.dart';

class VaultHomePage extends StatefulWidget {
  const VaultHomePage({super.key});

  @override
  State<VaultHomePage> createState() => _VaultHomePageState();
}

class _VaultHomePageState extends State<VaultHomePage> {
  List<SecretBasicInfo> _secrets = [];
  late Future<List<SecretBasicInfo>> _futureSecrets;

  Future<List<SecretBasicInfo>> fetchData() async {
    final List<SecretBasicInfo> secrets = await VaultApi.findAll();
    setState(() {
      _secrets = secrets;
    });
    return secrets;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _futureSecrets = fetchData();
    print("init state");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: _futureSecrets,
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
                return CredentialCard(secret: _secrets[index]);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
