import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CopyableInput extends StatefulWidget {
  final String value;
  final String label;
  final bool? hidable;
  final Function? onLoad;

  const CopyableInput(
      {key,
      required this.value,
      required this.label,
      this.hidable,
      this.onLoad})
      : super(key: key);

  @override
  State<CopyableInput> createState() => _CopyableInputState();
}

class _CopyableInputState extends State<CopyableInput> {
  String _password = '';
  bool _passwordVisibility = true;
  bool loadingCopyableInput = false;

  @override
  void initState() {
    super.initState();
    togglePasswordVisibility(false);
  }

  load() async {
    if (widget.onLoad != null) {
      setState(() {
        loadingCopyableInput = true;
      });
      await widget.onLoad!();
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        loadingCopyableInput = false;
      });
    }
  }

  togglePasswordVisibility(bool? mustLoad) async {
    if (mustLoad == true) {
      await load();
    }

    setState(() {
      _passwordVisibility = !_passwordVisibility;
      _password = _passwordVisibility == false && widget.hidable == true
          ? "*************************"
          : widget.value;
    });
  }

  void onCopy() async {
    await load();
    Clipboard.setData(ClipboardData(text: widget.value)).then((_) {
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
        loadingCopyableInput == true
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  widget.hidable == true
                      ? IconButton(
                          onPressed: () {
                            togglePasswordVisibility(true);
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
                ],
              )
      ])
    ]);
  }
}
