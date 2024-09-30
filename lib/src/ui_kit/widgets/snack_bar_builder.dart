import 'package:acces_make_mobile/src/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';

snackBarBuilder(BuildContext context, SnackBarOptions options) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: options.hasIcon,
            child: Row(
              children: [
                Icon(
                  options.type.toIcon(),
                  color: options.type.toForegroundColor(),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ),
          Text(
            options.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: options.type.toForegroundColor(),
            ),
          ),
          Visibility(
            visible: options.hasClose,
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Icon(
                Icons.close,
                color: options.type.toForegroundColor(),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: options.type.backgroundColor(),
      elevation: 12,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
    ),
  );
}

enum SnackBarType {
  success,
  error,
  warning,
  defaultType;

  Color backgroundColor() {
    switch (this) {
      case SnackBarType.defaultType:
        return Colors.transparent;
      case SnackBarType.error:
        return AppColors.red.withOpacity(0.1);
      case SnackBarType.success:
        return AppColors.green.withOpacity(0.1);
      case SnackBarType.warning:
        return AppColors.orange.withOpacity(0.1);
    }
  }

  Color toForegroundColor() {
    switch (this) {
      case SnackBarType.defaultType:
        return Colors.black;
      case SnackBarType.error:
        return AppColors.red;
      case SnackBarType.success:
        return AppColors.green;
      case SnackBarType.warning:
        return AppColors.orange;
    }
  }

  IconData toIcon() {
    switch (this) {
      case SnackBarType.defaultType:
        return Icons.info_outline_rounded;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.warning:
        return Icons.warning;
    }
  }
}

class SnackBarOptions {
  final String title;
  final SnackBarType type;
  final bool hasIcon;
  final bool hasClose;
  SnackBarOptions({
    required this.title,
    this.type = SnackBarType.defaultType,
    this.hasIcon = true,
    this.hasClose = false,
  });
}
