import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_localization_app/constant/appColor.dart';

class CustomWidgets {
  ///TextFeild Widget

  static Widget customTextFeild({
    required BuildContext context, // Pass BuildContext as a parameter
    String? name,
    String? hint,
    double? elevation,
    TextEditingController? controller,
    FocusNode? focusNode,
    Widget? icon,
    double? width,
    AutovalidateMode? autovalidateMode,
    int? maxLines,
    int? maxLength,
    Color? headingcolor,
    Color? hintColor,
    Color? fillcolor,
    double? height,
    TextInputType? keyboardtype,
    Function? onTap,
    var validate,
    bool isObstructed = false,
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
            color: headingcolor ?? Colors.white,
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
          elevation: elevation ?? 0,
          child: TextFormField(
            buildCounter:
                (
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
            obscureText: isObstructed,
            decoration: InputDecoration(
              suffixIcon: suffIcons,
              fillColor: isReadyOnly
                  ? Colors.grey.shade400
                  : fillcolor ?? Colors.white,
              filled: true,

              prefixIcon: icon,
              prefixIconColor: iconColor,

              hintText: hint,
              hintStyle: TextStyle(
                color: hintColor ?? Colors.white,
                fontSize: fontSize ?? 16,
                fontWeight: fontwgt ?? FontWeight.w600,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2),
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
            items: items.map((T value) {
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

  static Widget   customButton({
    required BuildContext context, // Pass BuildContext as a parameter
    String? buttonName,
    Function? onPressed,
    double? width,
    double? height,
    Color? btnColor,
    double? radius,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return ElevatedButton(
      onPressed: () {
        onPressed!();
      },
      style: ElevatedButton.styleFrom(
        fixedSize: Size(
          width ?? MediaQuery.of(context).size.width,
          height ?? 50,
        ), // Width: 200, Height: 50
        backgroundColor:
            btnColor ?? Colors.blue, // Default color if btnColor is null
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            radius ?? 10,
          ), // Set border radius
        ), // Button color
      ),
      child: FittedBox(
        child: Text(
          buttonName ?? 'Button',
          style: GoogleFonts.poppins(
            fontSize: fontSize ?? 12,
            fontWeight: fontWeight ?? FontWeight.w600,
            color: AppColor.primaryColor(context), // Text color
          ),
          
        ),
      ),
    );
  }

  ///
  ///
}
