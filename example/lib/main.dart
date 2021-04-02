import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';

import 'forms/login_form.dart';
import 'forms/registration_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoFormTheme(
      child: MaterialApp(
        title: 'Auto Form Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  FormShowcaseTile(
                    title: 'Login form',
                    child: AutoFormWidget<LoginForm>(
                      handleErrorOnSubmit: print,
                      formBuilder: () => LoginForm(),
                      submitButton: (Function(bool showLoadingDialog) submit) =>
                          Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: FlatButton(
                          child: Text('Submit'),
                          onPressed: () => submit(true),
                        ),
                      ),
                      onSubmitted: (TemplateForm form) async {
                        await Future.delayed(Duration(seconds: 2));

                        print(form.toMap());
                      },
                    ),
                  ),
                  FormShowcaseTile(
                    title: 'Registration form',
                    child: AutoFormWidget<RegistrationForm>(
                      formBuilder: () => RegistrationForm(),
                      submitButton: (Function(bool showLoadingDialog) submit) =>
                          Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: FlatButton(
                          child: Text('Submit'),
                          onPressed: () => submit(true),
                        ),
                      ),
                      onSubmitted: (TemplateForm form) {
                        print(form.toMap());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TabPageSelector(),
            )
          ],
        ),
      ),
    );
  }
}

class FormShowcaseTile extends StatelessWidget {
  const FormShowcaseTile({Key key, this.child, this.title}) : super(key: key);

  final String title;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                color: Colors.black12,
                offset: Offset(0, 10),
              ),
            ],
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
