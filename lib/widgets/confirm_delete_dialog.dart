
import 'package:flutter/material.dart';
import 'package:letjordangreen/core/utils/constants/app_colors.dart';
import 'package:letjordangreen/widgets/custom_button_widget.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmationButtonText;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.confirmationButtonText
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: AppColors.cardColor,
      title: Text(title,
         style: Theme.of(context).textTheme.bodyLarge
      ),
      content: Builder(
        builder: (context) {
          return Text(content,
              style: Theme.of(context).textTheme.bodyMedium
          );
        }
      )
      ,
      actions: <Widget>[
        TextButton(
          child:  Text("Cancel", style: const TextStyle(color: Colors.grey,fontSize: 14),),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          onPressed: onConfirm,
          child:  Text(confirmationButtonText,
           //   style: Theme.of(context).textTheme.displaySmall
          ),
        ),
      ],
    );
  }
}

class LogoutConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmationButtonText;
  final VoidCallback onConfirm;

  const LogoutConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.confirmationButtonText
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(12),
      contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 14),
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8)),
      backgroundColor: AppColors.cardColor,
      content: Builder(
        builder: (context) {
          var width = MediaQuery.of(context).size.width;
          return SizedBox(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(content,
                    style: Theme.of(context).textTheme.bodyMedium
                ),
                const SizedBox(height: 18,),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        color: Colors.grey,
                        text: "No",
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: CustomButton(
                        text: confirmationButtonText,
                        onTap: onConfirm,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
