# Flutter Auto Form

## [![pub package](https://img.shields.io/pub/v/flutter_auto_form.svg)](https://pub.dev/packages/flutter_auto_form)

<i>**The easiest way to create fully customizable forms with only a tiny amount of code.**</i>

## Installation

To use this plugin, add `flutter_auto_form` as a [dependency in your pubspec.yaml file](https://plus.fluttercommunity.dev/docs/overview).

<i>pubspec.yaml</i> <br><br>

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Your other packages  ...

<<<<<<< HEAD
  flutter_auto_form: ^0.4.3
=======
  flutter_auto_form: ^1.0.0
>>>>>>> 49a0ce67aa037e85d7ef317e89507cf62ef52ce3
```

## Support

* Platforms: **All platforms currently supported**
* Autofill hints: **Automatic support through AFTextFieldType**
* Validators: **Email, Url, Hex colour, Not null, Minimum string length, Same as another field, Alphanumeric.**
* Fields: **Password _(auto obscure toggle)_, Text, Number, Model _(built-in support for search through an api)_,
  Boolean, Sub-form _(cascading forms)_, Select _(dropdown field allowing only predefined values)_**
* Custom code: **You can customize and create new fields, validators, widgets as you please without even touching the
  source code of this package !**

## Example

The following gif illustrates some things you can realize with this package.

The source code is located in the example folder.

<img src='https://raw.githubusercontent.com/GaspardMerten/flutter_auto_form/master/demo.gif' height='350px'></img>

## Usage

The first step in creating a form with Flutter Auto Form is to create a class inheriting from the TemplateForm class.

import 'package:flutter_auto_form/flutter_auto_form.dart';

```dart
import 'package:flutter_auto_form/flutter_auto_form.dart';

class LoginForm extends TemplateForm {
  @override
  final List<Field> fields = [
    AFTextField(
      id: 'identifier',
      name: 'Identifier',
      validators: [
        MinimumStringLengthValidator(
          5,
              (e) => 'Min 5 characters, currently ${e?.length ?? 0} ',
        )
      ],
      type: AFTextFieldType.USERNAME,
    ),
    AFTextField(
      id: 'password',
      name: 'Password',
      validators: [
        MinimumStringLengthValidator(
          6,
              (e) => 'Min 6 characters, currently ${e?.length ?? 0} ',
        )
      ],
      type: AFTextFieldType.PASSWORD,
    ),
    AFBooleanField(
      id: 'accept-condition',
      name: 'Accept terms',
      validators: [ShouldBeTrueValidator('Please accept terms to continue?')],
      value: false,
    )
  ];
}

```

The second & (already) last step is to add the AFWidget wherever you would like to display a form.


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
    // do whatever you want when the form is submitted
    print(form.toMap());
  },
);
```

The AFTextField and AFNumberField are the only two fields available by defaults for the time being. 

## Advanced usage

<<<<<<< HEAD
_DOCUMENTATION COMING SOON_
=======
If you need to create your own field (date field, color field, ...) you can always create it by overriding the Field
class. Then to display a custom widget, create a stateful widget that extends the FieldStatefulWidget and of which the
state extends the FieldState class.
>>>>>>> 49a0ce67aa037e85d7ef317e89507cf62ef52ce3

##   

<i>This package is still under construction ! Do not hesitate to create an issue on the GitHub page if you find any bug or if you would like to see a new type of validator, field coming. And if you are that motivated if you would gladly review & accept your PR !