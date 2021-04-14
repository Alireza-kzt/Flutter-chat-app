import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_chat_app/features/authentication/presentation/widget/submit_button.dart';
import 'package:flutter_chat_app/features/authentication/presentation/widget/text_field_widget.dart';
import 'package:email_validator/email_validator.dart';
import '../../../../theme.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthBloc bloc = AuthBloc();
  var username;
  var email;
  var password;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 50.0),
              child: Text(
                "Sign up",
                style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, top: 10.0),
              height: 4.0,
              width: 50.0,
              color: theme.primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, top: 25.0),
              child: Text(
                "Create new Account",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      margin:
                          EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
                      hintText: 'Username',
                      icon: Icons.person_outline,
                      onSaved: (value) {
                        username = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) return "Enter Username";
                      },
                    ),
                    TextFieldWidget(
                      margin:
                          EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      hintText: 'Email',
                      icon: Icons.mail_outline,
                      onSaved: (value) {
                        email = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) return "Enter Email";
                        if (!EmailValidator.validate(value))
                          return "Enter correct Email";
                      },
                    ),
                    TextFieldWidget(
                      margin:
                          EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                      hintText: 'Password',
                      icon: Icons.lock_outline,
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
                        child: Text('Already have account?'),
                        onTap: () => Navigator.pushReplacementNamed(context, '/login'),
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
                              if (state is AuthInitial)
                                return SubmitButton(
                                    text: 'Sign in',
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        bloc.add(onSignInSubmit(
                                            username: username,
                                            email: email,
                                            password: password));
                                      }
                                    });
                              else if (state is Loading) {
                                {
                                  return CircularProgressIndicator();
                                }
                              } else if (state is Error)
                                return Text(
                                  'Error',
                                );
                              else if (state is Loaded)
                                return Container(
                                  width: 0,
                                  height: 0,
                                );
                            },
                          ),
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
