import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:agromate/screens/widgets/alert_box_widget.dart';

enum AgriOfficeLoginEvent {
  loginButtonClicked,
  // Add more events here if needed
}

enum AgriOfficeLoginState {
  initial,
  loading,
  success,
  failure,
  // Add more states here if needed
}

class AgriOfficeLoginBloc {
  final _stateController = StreamController<AgriOfficeLoginState>();
  final _eventController = StreamController<AgriOfficeLoginEvent>();

  Stream<AgriOfficeLoginState> get state => _stateController.stream;
  Sink<AgriOfficeLoginEvent> get event => _eventController.sink;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  AgriOfficeLoginBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _mapEventToState(AgriOfficeLoginEvent event) async {
    if (event == AgriOfficeLoginEvent.loginButtonClicked) {
      _stateController.add(AgriOfficeLoginState.loading);

      // Internet connection check
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        _stateController.addError('No Network Connection. Try Again!');
      } else {
        // Implement your login logic here
        // Example:
        // try {
        //   // Call your login function here
        //   // If login successful, add AgriOfficeLoginState.success
        //   // If login failed, add AgriOfficeLoginState.failure
        // } catch (e) {
        //   _stateController.addError(e.toString());
        // }
      }
    }
  }

  void forgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertBoxWidget(
        title: 'Forgot Password?',
        content: Text.rich(
          TextSpan(
            text: 'Contact admin\n',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.5,
                ),
            children: [
              TextSpan(
                text: 'Tel: 0756770843',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                    ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        buttonTitle: 'Okay',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  void signUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertBoxWidget(
        title: 'Don\'t have an account?',
        content: Text.rich(
          TextSpan(
            text: 'Contact IT Department\n',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  height: 1.5,
                ),
            children: [
              TextSpan(
                text: 'Tel: 0112223344',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                    ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        buttonTitle: 'Okay',
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
