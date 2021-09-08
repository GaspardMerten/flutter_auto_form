# Flutter Auto Form

## [![pub package](https://img.shields.io/pub/v/flutter_auto_form.svg)](https://pub.dev/packages/flutter_auto_form)

<i><b>The easiest way to create fully customizable forms with only a tiny amount of code.</b></i>

## Installation

To use this plugin, add `flutter_auto_form` as a [dependency in your pubspec.yaml file](https://plus.fluttercommunity.dev/docs/overview).

<i>pubspec.yaml</i> <br><br>

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Your other packages  ...
  
  flutter_auto_form: ^0.1.1
```
## Usage

The first step in creating a form with Flutter Auto Form is to create a class inheriting from the TemplateForm class.

import 'package:flutter_auto_form/flutter_auto_form.dart';

```dart
import 'package:flutter_auto_form/flutter_auto_form.dart'; // import the Flutter Auto Form package previously installed

/// A representation of the login form you wish to display.
class LoginForm extends TemplateForm {

  
  /// The 'fields' field is the only one you should override, it allows you to specify all the fields
  /// you want. 
  @override
  final List<Field> fields = [
    AFTextField(
      'identifier',
      'Identifier',
      [
        MinimumStringLengthValidator(
          5,
              (e) => 'Min 5 characters, currently ${e?.length ?? 0} ',
        )
      ],
      AFTextFieldType.USERNAME,
    ),
    AFTextField(
      'password',
      'Password',
      [
        MinimumStringLengthValidator(
          6,
              (e) => 'Min 6 characters, currently ${e?.length ?? 0} ',
        )
      ],
      AFTextFieldType.PASSWORD,
    )
  ];
}
```

The second & last step is to add the AFWidget wherever you would like to display a form.


```dart
AFWidget<RegistrationForm>(
  formBuilder: () => RegistrationForm(),
  submitButton: (Function({bool showLoadingDialog}) submit) => Padding(
    padding: const EdgeInsets.only(top: 32),
    child: MaterialButton(
      child: Text('Submit'),
      onPressed: () => submit(showLoadingDialog: true),
    ),
  ),
  onSubmitted: (RegistrationForm form) {
    print(form.toMap());
  },
);
```

The AFTextField and AFNumberField are the only two fields available by defaults for the time being. 

## Advanced usage

If you need to create your own field (date field, color field, ...) you can always create it by overriding
the Field class. Then override the buildField method of the AFThemeData class and wrap your top level widget with
a AFTheme widget to which you give your customized AFThemeData as argument.


## ---------------------------------------------------------------------

<i>This package is still under construction ! Do not hesitate to create an issue on the GitHub page if you find any bug or if you would like to see a new type of validator, field coming. And if you are that motivated if you would gladly review & accept your PR !