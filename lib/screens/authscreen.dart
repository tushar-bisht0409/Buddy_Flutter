import 'package:buddy/blocs/auth_bloc.dart';
import 'package:buddy/models/http_exception.dart';
import 'package:buddy/screens/homescreen.dart';
import 'package:buddy/screens/profileinfoscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum AuthMode { Signup, Login, Forgot }
AuthMode authMode = AuthMode.Login;

var _isLoading = false;

final authBloc = AuthBloc("", "");

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(color: Colors.white),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: StreamBuilder(
                        stream: authBloc.authStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            _isLoading = false;

                            if (snapshot.data['success'] == true) {
                              if (authMode == AuthMode.Signup) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ProfileInfoScreen()));
                                });
                              } else if (authMode == AuthMode.Login) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeScreen()));
                                });
                              }
                            } else if (snapshot.data['success'] == false &&
                                snapshot.data['msz'] != '') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  useRootNavigator: true,
                                  builder: (context) => AlertDialog(
                                    title: Text('An Error Occurred!'),
                                    content: Text(snapshot.data['msz']),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                          snapshot.data['msz'] = '';
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        },
                                      )
                                    ],
                                  ),
                                );
                              });
                            }
                          }
                          return AuthCard();
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> authData = {
    'email': '',
    'password': '',
  };

  final _passwordController = TextEditingController();

  void _showErrorDialog(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState.save();
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      if (authMode == AuthMode.Login) {
        authBloc.eventSink
            .add([authData['email'], authData['password'], AuthAction.Login]);
      } else if (authMode == AuthMode.Signup) {
        authBloc.eventSink
            .add([authData['email'], authData['password'], AuthAction.Signup]);
      } else if (authMode == AuthMode.Forgot) {
        authBloc.eventSink
            .add([authData['email'], authData['password'], AuthAction.Forgot]);
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  void _switchAuthMode() {
    if (authMode == AuthMode.Login) {
      if (mounted) {
        setState(() {
          authMode = AuthMode.Signup;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          authMode = AuthMode.Login;
        });
      }
    }
  }

  TextEditingController resetemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
        height: deviceSize.height,
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Card(
              elevation: 0,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: authMode == AuthMode.Signup ? 320 : 260,
                ),
                padding: EdgeInsets.all(18),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setHeight(100),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Image.asset('lib/assets/images/buddy.png',
                            fit: BoxFit.cover),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              right: 12,
                              left: 10,
                              bottom: deviceSize.height * 0.07,
                              top: deviceSize.height * 0.06),
                          child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(right: 20, left: 20),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'E-Mail',
                                      fillColor: Colors.blue[100],
                                      focusColor: Colors.blue[900],
                                      labelStyle:
                                          TextStyle(color: Colors.blue[200]),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue[900]))),
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    authData['email'] = value;
                                  },
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 20, left: 20),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Colors.blue[200]),
                                      border: OutlineInputBorder()),
                                  obscureText: true,
                                  controller: _passwordController,
                                  onSaved: (value) {
                                    authData['password'] = value;
                                  },
                                )),
                            if (authMode == AuthMode.Signup)
                              Padding(
                                  padding: EdgeInsets.only(
                                      right: 20, left: 20, top: 15),
                                  child: TextFormField(
                                      enabled: authMode == AuthMode.Signup,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Confirm Password',
                                          labelStyle: TextStyle(
                                              color: Colors.blue[200])),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value != _passwordController.text) {
                                          return "Password Doesn't Match";
                                        } else {
                                          return null;
                                        }
                                      })),
                          ]))),
                      SizedBox(
                        height: 5,
                      ),
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        Container(
                            //  height: ScreenUtil().setHeight(30),
                            child: Column(children: <Widget>[
                          ElevatedButton(
                            child: Text(
                              authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(16)),
                            ),
                            onPressed: _submit,
                          ),
                          TextButton(
                            child: Text(
                              '${authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(16)),
                            ),
                            onPressed: _switchAuthMode,
                          ),
                          TextButton(
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Reset Password'),

                                          content: TextFormField(
                                            controller: resetemail,
                                            decoration: InputDecoration(
                                                labelText: 'E-Mail',
                                                fillColor: Colors.blue[100],
                                                focusColor: Colors.blue[900],
                                                labelStyle: TextStyle(
                                                    color: Colors.blue[200]),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .green[900]))),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Card(
                                                    color: Colors.blue[600],
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(7),
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ))),
                                            TextButton(
                                                onPressed: () {
                                                  // FirebaseAuth.instance
                                                  //     .sendPasswordResetEmail(
                                                  //         email: resetemail
                                                  //             .text);
                                                },
                                                child: Card(
                                                    color: Colors.blue[600],
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(7),
                                                      child: Text(
                                                        'Continue',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )))
                                          ],
                                          elevation: 24,
                                          backgroundColor: Colors.white,
                                          // shape: CircularBorder(),
                                        ));
                              },
                              child: Center(
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                      color: Colors.blue[300], fontSize: 12),
                                ),
                              ))
                        ])),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
