import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CopyableInput extends StatefulWidget {
  final String value;
  final String label;
  final bool? hidable;

  const CopyableInput(
      {key, required this.value, required this.label, this.hidable})
      : super(key: key);

  @override
  State<CopyableInput> createState() => _CopyableInputState();
}

class _CopyableInputState extends State<CopyableInput> {
  String _password = '';
  bool _passwordVisibility = true;

  @override
  void initState() {
    super.initState();

    togglePasswordVisibility();
  }

  togglePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
      _password = _passwordVisibility == false && widget.hidable == true
          ? "*************************"
          : widget.value;
    });
  }

  void onCopy() {
    if (_passwordVisibility == false && widget.hidable == true) return;
    Clipboard.setData(ClipboardData(text: _password)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.copyClipboard)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      Row(children: [
        Expanded(
          child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Text(_password)),
        ),
        const SizedBox(width: 10),
        widget.hidable == true
            ? IconButton(
                onPressed: () {
                  togglePasswordVisibility();
                },
                icon: Icon(_passwordVisibility == false
                    ? Icons.visibility
                    : Icons.visibility_off),
                splashRadius: 25,
              )
            : Container(),
        IconButton(
          onPressed: () {
            onCopy();
          },
          icon: const Icon(Icons.content_copy),
          splashRadius: 25,
        )
      ])
    ]);
  }
}
