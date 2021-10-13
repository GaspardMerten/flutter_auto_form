import 'package:auto_form_example/forms/order_form.dart';
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
    return AFTheme(
      child: MaterialApp(
        title: 'Auto Form Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 50,
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: FormShowcaseTile(
                            title: 'Login form',
                            child: AFWidget<LoginForm>(
                              handleErrorOnSubmit: print,
                              formBuilder: () => LoginForm(),
                              submitButton: (Function() submit) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 32),
                                  child: ElevatedButton(
                                    child: const Text('Submit'),
                                    onPressed: () => submit(),
                                  ),
                                );
                              },
                              onSubmitted: (LoginForm form) async {
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                print(form.toMap());
                              },
                            ),
                          ),
                        ),
                        FormShowcaseTile(
                          title: 'Registration form',
                          child: AFWidget<RegistrationForm>(
                            formBuilder: () => RegistrationForm(),
                            submitButton: (Function() submit) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 32),
                                child: ElevatedButton(
                                  child: const Text('Submit'),
                                  onPressed: () {
                                    submit();
                                  },
                                ),
                              );
                            },
                            onSubmitted: (RegistrationForm form) {
                              print(form.toMap());
                            },
                          ),
                        ),
                        SingleChildScrollView(
                          child: FormShowcaseTile(
                            title: 'Order form',
                            child: AFWidget<OrderForm>(
                              formBuilder: () => OrderForm(),
                              submitButton: (Function() submit) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 32),
                                  child: ElevatedButton(
                                    child: const Text('Submit'),
                                    onPressed: () => submit(),
                                  ),
                                );
                              },
                              onSubmitted: (OrderForm form) {
                                print(form.toMap());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: TabPageSelector(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormShowcaseTile extends StatelessWidget {
  const FormShowcaseTile({Key? key, required this.child, required this.title})
      : super(key: key);

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
            boxShadow: const [
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
