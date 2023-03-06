<<<<<<< HEAD
## [0.4.3] - 10-25-2021

* Adding const constructors for default validators
* Updating dependencies to their latest version
=======
## [1.0.1] - 11-09-2022

* Adding sub forms through the addition of AFMultipleSubFormField, AFSubFormField and the linked default widgets.

## [1.0.0] - 10-21-2022

* Making some private endpoints public

## [1.0.0-dev.2] - 05-26-2022

* Updating the dropdown search package

## [1.0.0-dev.1] - 03-09-2022

* <b>Breaking changes</b>:
    * Dart 2.15
    * The AFTheme widget does not allow you to change the text field builder anymore. To do such a thing you should now
      extend the AFTextField and replace the widgetBuilder property by the one of your choice.
    * The AFFileField was removed due to too strong dependencies need (dart:io...).
    * Validators now accept null value by default. To prevent a field from being null, you should use the
      NotNullValidator or the NotEmptyValidator in the case of a string.
* Adding new build system
* Adding the possibility to make a AFTextField widget multiline
>>>>>>> 49a0ce67aa037e85d7ef317e89507cf62ef52ce3

## [0.4.2] - 10-18-2021

* Improving the custom field system

## [0.4.1] - 10-13-2021

* Adding unit test for each validator
* Normalizing the SameAsFieldValidator (constructor argument position was inverted)

## [0.4.0] - 10-13-2021

* <b>Breaking Changes</b>: the submitButton doesn't allow the showFutureDialog parameter. You should now use the
  enableSubmitFormWrapper argument of the AFWidget, AFFormState or if you want to specify the global behavior, use the
  AFTheme widget.

## [0.3.3] - 10-12-2021

* Fixing email validator

## [0.3.2] - 10-05-2021

* The multiple form field can now be instantiated with already existing form instances

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
