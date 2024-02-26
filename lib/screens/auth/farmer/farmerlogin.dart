import 'package:agromate/blocs/farmer/farmerlogingbloc.dart';
import 'package:flutter/material.dart';
import 'package:agromate/configs/custom_colors.dart';
import 'package:agromate/screens/widgets/button_widget.dart';
import 'package:agromate/screens/widgets/label_widget.dart';
import 'package:agromate/screens/widgets/text_field_widget.dart';


class FarmerLoging extends StatefulWidget {
  const FarmerLoging({Key? key}) : super(key: key);

  @override
  State<FarmerLoging> createState() => _FarmerLogingState();
}

class _FarmerLogingState extends State<FarmerLoging> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late FarmerLoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = FarmerLoginBloc();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _forgotPasswordDialog() {
    _loginBloc.forgotPasswordDialog(context);
  }

  void _signUpDialog() {
    _loginBloc.signUpDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColors.hazelColor,
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Farmer - Log In',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.brownColor,
                  ),
                ),
                Text(
                  'Enter your login credentials below!',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black.withOpacity(0.75),
                      ),
                ),
                const SizedBox(height: 40),
                const LabelWidget(label: 'Username'),
                TextFieldWidget(
                  hintText: 'johndoe',
                  controller: _usernameController,
                  suffixWidget: Icon(
                    Icons.person_outline,
                    size: 18,
                    color: Colors.black.withOpacity(0.65),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                const LabelWidget(label: 'Password'),
                TextFieldWidget(
                  hintText: 'Password@123',
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _forgotPasswordDialog(),
                    child: const Text('Forgot Password?'),
                  ),
                ),
                const SizedBox(height: 20),
                StreamBuilder<FarmerLoginState>(
                  stream: _loginBloc.state,
                  builder: (context, snapshot) {
                    return ButtonWidget(
                      width: double.infinity,
                      height: 45,
                      borderRadius: 10,
                      onPressed: () {
                        _loginBloc.event.add(FarmerLoginEvent.loginButtonClicked);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black.withOpacity(0.75),
                          ),
                    ),
                    TextButton(
                      onPressed: () => _signUpDialog(),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
