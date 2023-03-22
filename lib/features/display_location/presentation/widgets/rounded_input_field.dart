// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hierarchical_locations_widget/constants.dart';
import 'package:hierarchical_locations_widget/features/display_location/presentation/widgets/text_field_container.dart';

class RoundedInputField extends StatefulWidget {
  final String? hintText;
  final String? value;
  final IconData? icon;
  final onChanged;
  final onSaved;
  final onFieldSubmitted;
  final onEditingComplete;
  TextEditingController? controller;
  final FormFieldValidator<String?>? validator;

  final enabled;
  final String? label;
  final String? validationMessage;
  final String? helpText;
  final double? width;
  final autofillHints;
  final bool obscureText;
  final Widget? suffixWidget;
  final List<TextInputFormatter>? inputFormatters;
  int minLines, maxLines = 1;
  bool required;

  RoundedInputField(
      {Key? key,
      this.hintText,
      this.icon,
      this.onChanged,
      this.validator,
      this.onSaved,
      this.enabled = true,
      this.required = false,
      this.label,
      this.width = 250,
      this.onFieldSubmitted,
      this.controller,
      this.autofillHints,
      this.obscureText = false,
      this.onEditingComplete,
      this.inputFormatters,
      this.suffixWidget,
      this.value,
      this.minLines = 1,
      this.maxLines = 1,
      this.validationMessage,
      this.helpText})
      : super(key: key);

  @override
  State<RoundedInputField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  TextEditingController? controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    if (widget.value != null) controller?.text = widget.value!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldContainer(
            width: widget.width,
            label: widget.label,
            validationMessage: widget.validationMessage,
            helpText: widget.helpText,
            backgroundColor: widget.enabled ? editableColor : bgColor,
            child: TextFormField(
              autofillHints: widget.autofillHints,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              enabled: widget.enabled,
              controller: controller,
              onChanged: (String value) {
                if (widget.onChanged != null) {
                  widget.onChanged(value);
                }
              },
              minLines: widget.minLines,
              maxLines: widget.maxLines,
              onFieldSubmitted: widget.onFieldSubmitted,
              onEditingComplete: widget.onEditingComplete,
              onSaved: widget.onSaved,
              obscureText: widget.obscureText,
              validator: (String? value) {
                if (widget.validator != null) {
                  return widget.validator!(value);
                } else {
                  return null;
                }
              },
              cursorColor: kPrimaryColor,
              inputFormatters: widget.inputFormatters,
              decoration: InputDecoration(
                icon: widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: kPrimaryColor,
                      )
                    : null,
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                suffixIcon: widget.suffixWidget ??
                    (widget.enabled
                        ? const Icon(
                            Icons.edit,
                            size: 14,
                            color: kPrimaryColor,
                          )
                        : const Icon(
                            Icons.lock,
                            size: 14,
                            color: Color.fromARGB(255, 187, 184, 184),
                          )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
