import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:letjordangreen/features/feature_auth/feature_sign_up/cubit/signup_cubit.dart';
import 'package:letjordangreen/features/feature_auth/feature_sign_up/data/models/registered_user.dart';
import 'package:letjordangreen/features/feature_auth/feature_sign_up/presentation/processing/signup_provider.dart';
import 'package:letjordangreen/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';


class SignupCardWidget extends StatefulWidget {
  const SignupCardWidget({super.key});

  @override
  State<SignupCardWidget> createState() => _SignupCardWidgetState();
}

class _SignupCardWidgetState extends State<SignupCardWidget> {
  SignupProvider? signupProvider;

  String? signupAs;

  static const Color darkGreen = Color(0xff00451f);
  static  Color fieldCream = Color(0xfff3ead6).withOpacity(.5);
  static const Color textDark = Color(0xff1f2118);
  static const Color mutedText = Color(0xff4d544f);

  @override
  Widget build(BuildContext context) {
    signupProvider = Provider.of<SignupProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Selector<SignupProvider, Tuple2<bool, bool>>(
        selector: (context, listenTo) => Tuple2(
          listenTo.passwordVisible,
          listenTo.confirmPasswordVisible,
        ),
        builder: (context, signupProviderItems, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const SizedBox(height: 26),
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),


                _buildLogoHeader(),


                 Text(
                  "Join the Reforestation",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700, fontSize: 16),
                ),

                const SizedBox(height: 42),

                _buildLabel("Full Name"),
                const SizedBox(height: 9),
                CustomTextFormField(
                  hintText: "John Doe",
                  obscureText: false,
                  fillColor: fieldCream,
                  style: Theme.of(context).textTheme.bodyMedium,
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.black.withOpacity(0.38),
                    size: 22,
                  ),
                  maxLine: 1,
                  onChange: (String name) {
                    context.read<SignupCubit>().setName(name);
                  },
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 20),

                _buildLabel("Email Address"),
                const SizedBox(height: 9),
                CustomTextFormField(
                  hintText: "email@example.com",
                  obscureText: false,
                  fillColor: fieldCream,
                  style: Theme.of(context).textTheme.bodyMedium,

                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),

                  prefixIcon: Icon(
                    Icons.mail_outline_rounded,
                    color: Colors.black.withOpacity(0.38),
                    size: 22,
                  ),
                  maxLine: 1,
                  onChange: (String email) {
                    context.read<SignupCubit>().setEmail(email);
                  },
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 20),

                _buildLabel("Sign Up As"),
                const SizedBox(height: 9),
                _buildSignupAsDropdown(),

                const SizedBox(height: 20),

                _buildLabel("Password"),
                const SizedBox(height: 9),
                CustomTextFormField(
                  hintText: "••••••••",
                  fillColor: fieldCream,
                  style: Theme.of(context).textTheme.bodyMedium,

                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),

                  obscureText: signupProviderItems.item1,
                  onChange: (String password) {
                    context.read<SignupCubit>().setPassword(password);
                  },
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.black.withOpacity(0.38),
                    size: 22,
                  ),
                  suffixIcon: InkWell(
                    child: Icon(
                      signupProviderItems.item1
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 22,
                      color: signupProviderItems.item1
                          ? Colors.black.withOpacity(0.38)
                          : darkGreen,
                    ),
                    onTap: () {
                      signupProvider?.setPasswordVisible();
                    },
                  ),
                  maxLine: 1,
                  textInputType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),



                const SizedBox(height: 42),

                BlocListener<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state.status == SignUpStatus.success) {
                      // verifyYourEmailFunction(context);
                    }
                  },
                  child: BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      if (state.status == SignUpStatus.loading ||
                          state.status == SignUpStatus.submitting) {
                        return const SizedBox(
                          height: 62,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(darkGreen),
                            ),
                          ),
                        );
                      }

                      if (state.status == SignUpStatus.initial || state.status == SignUpStatus.error) {
                        return GestureDetector(
                          onTap: () {
                            if (signupAs == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please choose Farmer or Company"),
                                ),
                              );
                              return;
                            }

                            RegisteredUser registeredUser = RegisteredUser(
                              name: state.name,
                              lastName: state.lastName,
                              password: state.password,
                              confirmPassword: state.password,
                              email: state.email,
                              phoneNumber: state.phoneNumber,

                              // Add this only if your RegisteredUser model supports it:
                              // accountType: signupAs,
                              // userType: signupAs,
                              // role: signupAs,
                            );

                            context.read<SignupCubit>().signupWithCredentials(
                              registeredUser: registeredUser,
                              context: context,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 48,
                            decoration: BoxDecoration(
                              color: darkGreen,
                              borderRadius: BorderRadius.circular(31),
                              boxShadow: [
                                BoxShadow(
                                  color: darkGreen.withOpacity(0.22),
                                  blurRadius: 22,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Create Account",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white, fontSize: 15),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 21,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),

                const SizedBox(height: 34),

                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text:  TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(text: "Already have an account?  "),
                          TextSpan(
                            text: "Login now",
                            style: TextStyle(
                              color: darkGreen,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogoHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   width: 50,
        //   height: 50,
        //   decoration: BoxDecoration(
        //     color: darkGreen,
        //     borderRadius: BorderRadius.circular(10),
        //     boxShadow: [
        //       BoxShadow(
        //         color: darkGreen.withOpacity(0.25),
        //         blurRadius: 14,
        //         offset: const Offset(0, 8),
        //       ),
        //     ],
        //   ),
        //   child: Center(
        //     child: CustomPaint(
        //       size: const Size(25, 28),
        //       painter: TreeLogoPainter(),
        //     ),
        //   ),
        // ),
      //  const SizedBox(width: 13),
        const Text(
          "Let Gordan Green",
          style: TextStyle(
            color: darkGreen,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.7,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: mutedText,
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildSignupAsDropdown() {
    return DropdownButtonFormField<String>(
      value: signupAs,
      decoration: InputDecoration(
        filled: true,
        fillColor: fieldCream,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        prefixIcon: Icon(
          Icons.eco_outlined,
          color: Colors.black.withOpacity(0.38),
          size: 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.2,
          ),
        ),
      ),
      hint: Text(
        "Choose account type",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
      ),
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Colors.black.withOpacity(0.55),
      ),
      dropdownColor: const Color(0xfffbf5ec),
      borderRadius: BorderRadius.circular(14),
      style: const TextStyle(
        color: textDark,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      items:  [
        DropdownMenuItem(
          value: "farmer",
          child: Text("Farmer", style: Theme.of(context).textTheme.bodyMedium),
        ),
        DropdownMenuItem(
          value: "company",
          child: Text("Company", style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
      onChanged: (value) {
        setState(() {
          signupAs = value;
        });

        // Use this only if you have this function in SignupCubit:
        // context.read<SignupCubit>().setAccountType(value ?? "");
      },
    );
  }

}