import 'package:flutter/material.dart';
import 'package:smarter_text_field/smarter_text_field.dart';

/// The default text field builder used by the [AFTheme] widget.
/// See [TextFieldWidgetBuilder] if you want to create your own text field
/// builder compatible with the requirement of the [AFTheme].
Widget kTextFieldWidgetBuilder(
  BuildContext context, {
  String? labelText,
  Function(String value)? validator,
  required TextEditingController controller,
  required FocusNode focusNode,
  required bool forceError,
  required TextInputAction action,
  Function()? completeAction,
  required List<String> autoFillHints,
  required bool obscureText,
}) {
  final InputDecoration decoration = InputDecoration(
    labelText: labelText,
  ).applyDefaults(Theme.of(context).inputDecorationTheme);

  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: SmartTextFormField(
      decoration: decoration,
      validator: validator as String? Function(String?)?,
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

/// The default loading dialog builder used by the [AFTheme] widget.
/// See [FutureLoadingWidget] if you want to create your own loading dialog
/// compatible with the requirement of the [AFTheme].
Future<T> kShowFutureLoadingWidget<T>({
  required BuildContext context,
  required Future<T> future,
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

/// The widget that is displayed by the [kShowFutureLoadingWidget].
class _KLoadingWidget extends StatelessWidget {
  const _KLoadingWidget({
    Key? key,
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
