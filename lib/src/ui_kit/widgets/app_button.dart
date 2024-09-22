import 'package:flutter/material.dart';

import '../ui_kit.dart';
class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? overlayColor;
  final double elevation;
  final bool isLoading;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  
  const AppButton({
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.overlayColor,
    this.elevation = 0,
    this.isLoading = false,
    this.borderRadius = 8.0,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,  
      style: ButtonStyle(
        elevation: const WidgetStatePropertyAll<double>(0),
        backgroundColor: WidgetStatePropertyAll<Color>(
          backgroundColor ?? AppColors.blue,
        ),
        foregroundColor: WidgetStatePropertyAll<Color>(
          foregroundColor ?? AppColors.white,
        ),
        overlayColor: WidgetStatePropertyAll<Color>(
          overlayColor ?? Colors.black12, 
        ),
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: foregroundColor ?? AppColors.white,  
            ),
          ),
        ),
      ),
      child: isLoading
          ? const AppLoader() 
          : child,
    );
  }
}