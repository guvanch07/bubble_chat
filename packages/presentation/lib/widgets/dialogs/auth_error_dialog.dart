import 'package:flutter/material.dart';
import 'package:presentation/screens/auth/bloc/auth_error.dart';
import 'package:presentation/widgets/dialogs/generic_dialog.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) =>
    showGenericDialog(
      context: context,
      title: authError.dialogTitle,
      content: authError.dialogText,
      optionsBuilder: () => {
        'OK': true,
      },
    );
