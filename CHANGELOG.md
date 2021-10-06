## [0.3.1] - 10-05-2021

* Improving the way sub-forms work

## [0.3.0] - 10-05-2021

* Adding a Widget suffix to each internal field's widget.
* Adding support for AFFormField and AFMultipleFormField to allow sub-form system. (you now create infinite forms in a
  cascade)
* Fixing dart:io import (for web)
* Adding some documentation to internal widgets
* Fixing the email validator regex

## [0.2.9] - 10-04-2021

* An issue with the SimpleFile bytes property has been fixed.

## [0.2.8] - 09-28-2021

* Adding SearchMultipleModelsField, AFSearchMultipleModelsField

## [0.2.7] - 09-23-2021

* Adding FileField & SelectField
* Moving boolean field to a widget of its own
* Adding default padding on submit button

## [0.2.6] - 09-23-2021

* Fixing hex color validator

## [0.2.5] - 09-23-2021

* Updating the hex color validator. The validation mode can now be specified (with #, without or both).
* Adding the possibility to disable the final action with the AFWidget.

## [0.2.4] - 09-23-2021

* Exporting the validator.dart file inside the library main file.

## [0.2.3] - 09-09-2021

* Moving to a MIT license

## [0.2.2] - 09-09-2021

* Adding AFSearchModelField
* Adding AFBooleanField
* Improving example
* Improving README.md
* Adding dropdown_search as a dependency

## [0.2.1] - 09-09-2021

* AFWidgetState is now a public api.

## [0.2.0] - 09-09-2021

* Moving from positional to named parameters for AFTextField.
* Adding support for custom parser for the Field class.
* Improving doc

## [0.1.1] - 09-08-2021.

* Fixing documentation

## [0.1.0] - 09-08-2021.

* Adding documentation
* Adding the ability to specify the type for the NotNullValidator.

## [0.0.9] - 07-21-2021.

* Adding auto trim for email field validator

## [0.0.8] - 07-21-2021.

* Adding auto trim for email field

## [0.0.7] - 06-27-2021.

* Renaming AutoForm to AF => less verbose
* Fixing a type issue
* Decoupling the AFTheme into AFTheme and AFThemeData

## [0.0.6] - 04-07-2021.

* Migrating to null safety

## [0.0.5] - 04-02-2021.

* Fixing issue with the loading dialog
* Adding first pieces of documentation

## [0.0.4] - 04-02-2021.

* Removing debug code
* Refactoring code
* Upgrading smarted_text_field to v0.0.2

## [0.0.3] - 04-02-2021.

* Renaming AutoFormFormState to AutoFormWidgetState

## [0.0.2] - 04-02-2021.

* Replacing the config singleton with an InheritedWidget.
* Adding the ability to handle error message on form submission

## [0.0.1] - 03-31-2021.

* Init version
