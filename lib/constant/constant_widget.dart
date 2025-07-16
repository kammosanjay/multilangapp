import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomWidgets {
  ///TextFeild Widget

  static Widget customTextFeild({
    required BuildContext context, // Pass BuildContext as a parameter
    String? name,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    Widget? icon,
    double? width,
    AutovalidateMode? autovalidateMode,
    int? maxLines,
    int? maxLength,
    Color? color,
    double? height,
    TextInputType? keyboardtype,
    Function? onTap,
    var validate,
    bool isPassword = false,
    Color? iconColor,
    Widget? suffIcons,
    TextInputAction? action,
    bool isReadyOnly = false,
    String label = "",
    var fontSize,
    var fontwgt,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color ?? Colors.white,
            fontSize: fontSize ?? 16,
            fontWeight: fontwgt ?? FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Card(
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 5,
          child: TextFormField(
            buildCounter: (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) {
              return null;
            },
            focusNode: focusNode,
            readOnly: isReadyOnly,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardtype,
            validator: validate,

            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            controller: controller ?? TextEditingController(),
            textAlignVertical: TextAlignVertical.center,
            textInputAction: action,

            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
            obscureText: isPassword,
            decoration: InputDecoration(
              suffixIcon: suffIcons,
              fillColor: isReadyOnly ? Colors.grey.shade400 : Colors.white,
              filled: true,
              prefixIcon: icon,
              prefixIconColor: iconColor,

              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // custom dropdown widget
  static Widget customDropdownField<T>({
    required BuildContext context,
    required List<T> items,
    required T? selectedItem,
    required ValueChanged<T?> onChanged,

    String? hint,
    Color? color,
    Widget? icon,
    Color? iconColor,
    Widget? suffixIcon,
    double? width,
    FocusNode? focusNode,
    AutovalidateMode? autovalidateMode,
    bool readOnly = false,
    var validate,
    String label = "",
    var fontSize,
    var fontwgt,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color ?? Colors.white,
            fontSize: fontSize ?? 16,
            fontWeight: fontwgt ?? FontWeight.w600,
          ),
        ),
        SizedBox(height: 10),
        Card(
          color: readOnly ? Colors.grey.shade400 : Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 5,
          child: DropdownButtonFormField<T>(
            value: selectedItem,
            isExpanded: true,
            focusNode: focusNode,
            selectedItemBuilder: (BuildContext context) {
              return items.map<Widget>((T item) {
                return Text("$item");
              }).toList();
            },
            validator: validate,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            icon: suffixIcon,
            decoration: InputDecoration(
              prefixIcon: icon,
              prefixIconColor: iconColor,
              constraints: BoxConstraints(
                maxHeight: 60,

                maxWidth: width ?? MediaQuery.of(context).size.width,
              ),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            items:
                items.map((T value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
            onChanged: readOnly ? null : onChanged,
          ),
        ),
      ],
    );
  }

  ///Button Widget

  static Widget customButton({
    required BuildContext context, // Pass BuildContext as a parameter
    String? buttonName,
    Function? onPressed,
  }) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      child: Text(buttonName!, style: TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(w, h * 0.07), // Width: 200, Height: 50
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Set border radius
        ), // Button color
      ),
    );
  }

  ///
  ///
  static Widget customTextFieldupdate({
    required BuildContext context,
    required String? errorText,
    String? name,
    String? hint,
    TextEditingController? controller,
    FocusNode? focusNode,
    Widget? icon,
    double? width,
    AutovalidateMode? autovalidateMode,
    int? maxLines,
    int? maxLength,
    Color? color,
    double? height,
    TextInputType? keyboardtype,
    Function? onTap,
    bool isPassword = false,
    Color? iconColor,
    Widget? suffIcons,
    TextInputAction? action,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 5,
          child: TextFormField(
            focusNode: focusNode,
            keyboardType: keyboardtype,
            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            textInputAction: action,
            onTap: () {
              if (onTap != null) {
                onTap();
              }
            },
            obscureText: isPassword,
            decoration: InputDecoration(
              counterText: '',
              suffixIcon: suffIcons,
              prefixIcon: icon,
              prefixIconColor: iconColor,
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: InputBorder.none,
            ),
          ),
        ),

        // 🛑 Custom error message outside card
        if (errorText != null && errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
