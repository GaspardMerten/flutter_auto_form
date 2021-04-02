import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/configuration/smart_text_field.dart';

Widget kTextFieldWidgetBuilder(
  BuildContext context, {
  String labelText,
  Function(String value) validator,
  TextEditingController controller,
  FocusNode focusNode,
  bool forceError,
  TextInputAction action,
  Function() completeAction,
  List<String> autoFillHints,
  bool obscureText,
}) {
  final InputDecoration decoration = InputDecoration(
    labelText: labelText,
  ).applyDefaults(Theme.of(context).inputDecorationTheme);

  print(forceError);

  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: SmartTextFormField(
      decoration: decoration,
      validator: validator,
      controller: controller,
      autoFillHints: autoFillHints,
      focusNode: focusNode,
      obscureText: obscureText,
      action: action,
      forceError: forceError,
      completeAction: completeAction,
      displayObscureTextToggle: obscureText,
    ),
  );
}

Future<T> kShowFutureLoadingWidget<T>({
  @required BuildContext context,
  @required Future<T> future,
}) async {
  showDialog<dynamic>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => const _KLoadingWidget(),
  );

  final T response = await future;

  Navigator.pop(context);

  return response;
}

class _KLoadingWidget extends StatelessWidget {
  const _KLoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.5),
              color: Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
