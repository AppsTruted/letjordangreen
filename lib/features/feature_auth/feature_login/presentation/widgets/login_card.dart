import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/core/utils/constants/constants.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/cubit/login_cubit.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/presentation/processing/login_provider.dart';
import 'package:letjordangreen/widgets/custom_button_widget.dart';
import 'package:letjordangreen/widgets/custom_text_form_field.dart';

class LoginCardWidget extends StatefulWidget {

  const LoginCardWidget({super.key});

  @override
  State<LoginCardWidget> createState() => _LoginCardWidgetState();
}

class _LoginCardWidgetState extends State<LoginCardWidget> {
  LoginProvider? loginProvider;

  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            CustomTextFormField(
              hintText:  "Email",
              autofillHints: const [AutofillHints.email],
              obscureText: false,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
              maxLine: 1,
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.4)),
              ),
              onChange: (String email) {
                context.read<LoginCubit>().setEmail(email);
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isPasswordVisible,
              builder: (context, bool isPasswordVisible, Widget? widget) {
                return CustomTextFormField(
                  textInputType: TextInputType.visiblePassword,
                  onChange: (String password) {
                    context.read<LoginCubit>().setPassword(password);
                  },
                  maxLine: 1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  hintText: "Password",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(.4)),
                  ),
                  obscureText: !isPasswordVisible,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18),
                  suffixIcon: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _isPasswordVisible.value = !_isPasswordVisible.value;
                    },
                    child: Icon(
                      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              },
            ),


            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  context.push(AppRoutes.forgetPassword);
                },
                child:  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget your password?",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.primaryColor),
                    ))),
            const SizedBox(
              height: 50,
            ),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {

                if ( state.status == LoginStatus.error) {
                  return Center(child: Text(state.error??"", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),));
                }
                return const SizedBox();
              },
            ),
            const SizedBox(
              height: 12,
            ),
            BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.success) {
                context.go(AppRoutes.splashScreen);

               // context.read<LoginCubit>().updateUserFirebase().then((onValue) {
               //   context.go(AppRoutes.splashScreen);
               // });

              }

            },
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                if (state.status == LoginStatus.loading || state.status == LoginStatus.submitting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state.status == LoginStatus.initial || state.status == LoginStatus.error) {
                  return CustomButton(
                    onTap: () => {
                      context.read<LoginCubit>().loginWithCredentials(context: context),
                    },
                    text: "Continue",

                  );
                }
                return const SizedBox();
              },
            ),
                        ),
          ],
        ),
      ),
    );
  }
}
