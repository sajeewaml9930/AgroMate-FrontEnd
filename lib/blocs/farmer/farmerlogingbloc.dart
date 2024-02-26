import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:agromate/screens/widgets/alert_box_widget.dart';

enum FarmerLoginEvent {
  loginButtonClicked,
  // Add more events here if needed
}

enum FarmerLoginState {
  initial,
  loading,
  success,
  failure,
  // Add more states here if needed
}

class FarmerLoginBloc {
  final _stateController = StreamController<FarmerLoginState>();
  final _eventController = StreamController<FarmerLoginEvent>();

  Stream<FarmerLoginState> get state => _stateController.stream;
  Sink<FarmerLoginEvent> get event => _eventController.sink;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  FarmerLoginBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _mapEventToState(FarmerLoginEvent event) async {
    if (event == FarmerLoginEvent.loginButtonClicked) {
      _stateController.add(FarmerLoginState.loading);

      // Internet connection check
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        _stateController.addError('No Network Connection. Try Again!');
      } else {
        // Implement your login logic here
        // Example:
        // try {
        //   // Call your login function here
        //   // If login successful, add FarmerLoginState.success
        //   // If login failed, add FarmerLoginState.failure
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
}
