import 'package:acces_make_mobile/src/ui_kit/ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.label,
    super.key,
    this.hintText,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.errorText,
    this.decoration,
    this.onChanged,
    this.onEditingComplete,
    this.onAppPrivateCommand,
    this.validator,
    this.footer,
    this.suffixIcon,
    this.inputFormatters,
    this.focusNode,
    this.maxLines,
    this.maxLenght,
  }) : assert(
          isPassword == false || suffixIcon == null,
          '''You can use only one of this attributes. If you want to use suffixIcon - set isPassword to false''',
        );

  factory AppTextField.password({
    required String label,
    String? hintText,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Widget? footer,
  }) {
    return AppTextField(
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      controller: controller,
      hintText: hintText,
      label: label,
      validator: validator,
      isPassword: true,
      footer: footer,
    );
  }

  final String? label;
  final String? hintText;
  final bool isPassword;
  final Widget? footer;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? errorText;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String, Map<String, dynamic>)? onAppPrivateCommand;
  final int? maxLines;
  final int? maxLenght;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscureText;
  late FocusNode focusNode;

  @override
  void initState() {
    obscureText = widget.isPassword;
    if (widget.focusNode != null) {
      focusNode = widget.focusNode!;
    } else {
      focusNode = FocusNode();
    }
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        widget.onEditingComplete?.call();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Visibility(
                visible: widget.label != null,
                child: Text(
                  widget.label!,
                  style: AppFonts.displayMedium.copyWith(
                    color: Colors.black,
                  ),
                ),
              )
            : const Offstage(),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onTapOutside: (event) {
            focusNode.unfocus();
            widget.onEditingComplete?.call();
          },
          maxLines: widget.maxLines,
          maxLength: widget.maxLenght,
          style: AppFonts.displayMedium,
          controller: widget.controller,
          focusNode: focusNode,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: obscureText,
          onChanged: (value) {
            widget.onChanged?.call(value);
          },
          onEditingComplete: () {
            widget.onEditingComplete?.call();

            focusNode.unfocus();
          },
          onAppPrivateCommand: widget.onAppPrivateCommand,
          obscuringCharacter: '*',
          decoration: widget.decoration ??
              InputDecoration(
                isDense: false,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                hintText: widget.hintText,
                errorText: widget.errorText,
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: widget.suffixIcon ??
                      (widget.isPassword
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: obscureText ? const Icon(Icons.password) : const Icon(Icons.password),
                            )
                          : null),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 16,
                  minWidth: 16,
                ),
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (widget.footer != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: widget.footer,
          ),
      ],
    );
  }
}
