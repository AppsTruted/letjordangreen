import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/core/router/routes_names.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/features/feature_auth/feature_login/cubit/login_cubit.dart';
import 'package:letjordangreen/widgets/custom_text_form_field.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  static const Color darkGreen = Color(0xff00451f);
  static  Color fieldCream = Color(0xffeee4cf).withOpacity(.5);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/background-login.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.14),
                    Colors.black.withOpacity(0.44),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                children: [
                  const SizedBox(height: 60),

                  // Row(
                  //   children: [
                  //     Container(
                  //       width: 42,
                  //       height: 42,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white.withOpacity(0.15),
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       child: IconButton(
                  //         onPressed: () => context.pop(),
                  //         icon: const Icon(
                  //           Icons.arrow_back_rounded,
                  //           color: Colors.white,
                  //           size: 22,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  const SizedBox(height: 18),


                  const Text(
                    'Let Jordan Green',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.8,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Restoring landscapes, building futures.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.92),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 34),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
                        decoration: BoxDecoration(
                          color: AppColors.scaffoldColor,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome Back',
                              style: TextStyle(
                                color: darkGreen,
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 26),

                            _buildLoginForm(),

                            const SizedBox(height: 18),

                            BlocBuilder<LoginCubit, LoginState>(
                              builder: (context, state) {
                                if (state.status == LoginStatus.error) {
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.red.withOpacity(0.25),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.error_outline_rounded,
                                          color: Colors.red.shade400,
                                          size: 21,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            state.error ?? "An error occurred",
                                            style: TextStyle(
                                              color: Colors.red.shade500,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return const SizedBox();
                              },
                            ),

                            const SizedBox(height: 18),

                            BlocListener<LoginCubit, LoginState>(
                              listener: (context, state) {
                                if (state.status == LoginStatus.success) {
                                  context.go(AppRoutes.splashScreen);
                                  log("state.status login ${state.status}");
                                }
                              },
                              child: BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  if (state.status == LoginStatus.loading ||
                                      state.status == LoginStatus.submitting) {
                                    return const SizedBox(
                                      width: double.infinity,
                                      height: 53,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            darkGreen,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState?.validate() ?? false) {
                                        context
                                            .read<LoginCubit>()
                                            .loginWithCredentials(context: context);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: darkGreen,
                                        borderRadius: BorderRadius.circular(28),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.28),
                                            blurRadius: 16,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Sign In',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 45),

                  InkWell(
                    onTap: () {
                      context.push(AppRoutes.signup);
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.86),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        children: const [
                          TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Create account',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // const SizedBox(height: 46),
                  //
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     _footerLink('Privacy Policy'),
                  //     _footerLink('Terms of Service'),
                  //     _footerLink('Support'),
                  //   ],
                  // ),
                  //
                  // const SizedBox(height: 26),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Email Address",
            style: TextStyle(
              color: Color(0xff4d544f),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            style: Theme.of(context).textTheme.bodyMedium,
            textInputType: TextInputType.emailAddress,
            onChange: (String email) {
              context.read<LoginCubit>().setEmail(email);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return "Please enter a valid email address";
              }
              return null;
            },
            fillColor: fieldCream,
            hintText: "name@letjordangreen.com",
            prefixIcon: const Icon(
              Icons.mail_outline_rounded,
              color: Colors.grey,
              size: 21,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Password",
                style: TextStyle(
                  color: Color(0xff4d544f),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Add forgot password action here if you have one.
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xff3f6b45),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          CustomTextFormField(
            style: Theme.of(context).textTheme.bodyMedium,

            obscureText: _obscurePassword,
            onChange: (String password) {
              context.read<LoginCubit>().setPassword(password);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
            hintText: "••••••••",
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              color: Colors.grey,
              size: 21,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: Colors.black.withOpacity(0.55),
                size: 21,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            maxLine: 1,
            fillColor: fieldCream,
          ),
        ],
      ),
    );
  }

}