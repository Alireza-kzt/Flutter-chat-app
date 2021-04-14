import 'package:flutter/material.dart';
import 'package:flutter_chat_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_chat_app/features/authentication/presentation/widget/submit_button.dart';
import 'package:flutter_chat_app/features/authentication/presentation/widget/text_field_widget.dart';
import 'package:flutter_chat_app/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc bloc = AuthBloc();
  var _formKey = GlobalKey<FormState>();
  var email;
  var password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0, top: 50.0),
            child: Text(
              "Login",
              style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, top: 10.0),
            height: 4.0,
            width: 50.0,
            color: theme.primaryColor,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldWidget(
                    icon: Icons.email_outlined,
                    hintText: "Email",
                    onSaved: (value) {
                      email = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) return "Enter Email";
                      if (!EmailValidator.validate(value))
                        return "Enter correct Email";
                    },
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
                  ),
                  TextFieldWidget(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 20),
                    icon: Icons.lock_outline,
                    hintText: "Password",
                    onSaved: (value) {
                      password = value;
                    },
                    validator: (String value) {
                      if (value.length < 6)
                        return "Password should be at least 6 characters";
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 30.0),
                    child: InkWell(
                      child: Text('Create new account'),
                      onTap: () => Navigator.pushReplacementNamed(context, '/auth'),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 40.0),
                      child: BlocListener<AuthBloc, AuthState>(
                        cubit: bloc,
                        listener: (context, state) {
                          if (state is Loaded) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        },
                        child: BlocBuilder<AuthBloc, AuthState>(
                          cubit: bloc,
                          builder: (context, state) {
                            if (state is AuthInitial) {
                              return SubmitButton(
                                  text: 'Login',
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      bloc.add(onLoginSubmit(
                                          email: email, password: password));
                                    }
                                  });
                            } else if (state is Loading) {
                              FocusScope.of(context).unfocus();
                              return CircularProgressIndicator();
                            } else if (state is Error) {
                              return Text(
                                'Error',
                              );
                            } else if (state is Loaded) {
                              return Container(
                                width: 0,
                                height: 0,
                              );
                            }
                          },
                        ),
                      )),
                ],
              ))
        ],
      )),
    );
  }
}
