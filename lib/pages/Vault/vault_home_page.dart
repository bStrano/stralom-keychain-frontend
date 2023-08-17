import 'package:flutter/material.dart';
import 'package:keychain_frontend/pages/Vault/widgets/credential_card.dart';

class VaultHomePage extends StatefulWidget {
  const VaultHomePage({super.key});

  @override
  State<VaultHomePage> createState() => _VaultHomePageState();
}

class _VaultHomePageState extends State<VaultHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: GridView.builder(
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CredentialCard();
        },
      ),
    );
  }
}
