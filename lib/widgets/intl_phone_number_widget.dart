// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl_phone_field/country_picker_dialog.dart';
// import 'dart:ui' as ui;
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:loyalitytech/features/feature_auth/feature_phone_auth/cubit/phone_auth_cubit.dart';
// import 'package:loyalitytech/features/feature_auth/feature_sign_up/cubits/signup_cubit/signup_cubit.dart';
//
// class IntlPhoneNumberWidget extends StatelessWidget {
//   final InputBorder? border;
//   final Function(String, String)? onPhoneNumberCompleted;
//
//   const IntlPhoneNumberWidget({
//     super.key,
//     this.border,
//      this.onPhoneNumberCompleted,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: ui.TextDirection.ltr,
//       child: IntlPhoneField(
//         style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
//         dropdownTextStyle: const TextStyle(color: Colors.black),
//         initialCountryCode: "JO",
//         autovalidateMode: AutovalidateMode.always,
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.symmetric(vertical: 16),
//           hintText: "X XXXX XXXX",
//           filled: false,
//           hintStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey.withOpacity(.3)),
//           counterStyle: const TextStyle(color: Colors.grey),
//           prefixIconColor: Colors.black,
//           border: border ?? UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
//           ),
//           errorBorder:  const UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.red),
//           ),
//           fillColor: Colors.grey.withOpacity(.1),
//           focusedBorder: border?? UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
//           ),
//           enabledBorder: border?? UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
//           ),
//           disabledBorder: border?? UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.withOpacity(.3)),
//           ),
//         ),
//
//         onSubmitted: (value) {
//           FocusScope.of(context).unfocus(); // Close keyboard
//         },
//
//         onChanged: (phone) {
//
//           context.read<SignupCubit>().setPhoneNumber(phone.completeNumber);
//           context.read<PhoneAuthCubit>().setPhoneCountryCode(phone.countryCode);
//           context.read<PhoneAuthCubit>().setPhone(phone.number);
//
//           log("phone ${phone}");
//           if(onPhoneNumberCompleted != null) {
//             onPhoneNumberCompleted!(phone.completeNumber, phone.number); // Return complete number
//           }
//         },
//
//         validator: (value) {
//           if (value == null || value.number.isEmpty || value.completeNumber.isEmpty) {
//             return "Please fill this field";
//           }
//           return null;
//         },
//
//         onCountryChanged: (country) {
//           log('Country changed to: ${country.name}');
//           context.read<PhoneAuthCubit>().setCountry(country.code);
//           // context.read<PhoneAuthCubit>().setPhoneCountryCode(country.countryCode);
//
//         },
//
//         pickerDialogStyle: PickerDialogStyle(
//           backgroundColor: Colors.white,
//           countryNameStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
//           countryCodeStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
//         ),
//
//         textInputAction: TextInputAction.done,
//         keyboardType: TextInputType.number,
//       ),
//     );
//   }
// }
