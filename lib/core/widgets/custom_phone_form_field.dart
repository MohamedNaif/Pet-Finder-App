import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:intl_phone_field/phone_number.dart';
import 'package:pet_finder_app/config/theme/app_colors.dart';
import 'package:pet_finder_app/config/theme/app_style.dart';
import 'package:pet_finder_app/core/constants/app_assets.dart';
import 'package:pet_finder_app/core/utils/phone_number_parser.dart';

class CustomPhoneFormField extends StatefulWidget {
  const CustomPhoneFormField({
    super.key,
    this.controller,
    this.onCountryChanged,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.width,
    this.initialCountryCode = 'IQ',
    this.enabled = true,
    this.maxLength,
    this.keyboardType,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final Function(String)? onCountryChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final TextStyle? hintStyle;
  final double? width;
  final String initialCountryCode;
  final bool enabled;
  final int? maxLength;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  @override
  State<CustomPhoneFormField> createState() => _CustomPhoneFormFieldState();
}

class _CustomPhoneFormFieldState extends State<CustomPhoneFormField> {
  // bool _isTyping = false;
  String? _errorMessage;
  late String countryCode;
  late String flagIsoCode;

  @override
  void initState() {
    super.initState();
    _initializeCountryData();
  }

  void _initializeCountryData() {
    try {
      final countryEntry = PhoneNumberParser.countryCodes.entries.firstWhere(
        (entry) => entry.value == widget.initialCountryCode,
        orElse: () =>
            const MapEntry('+964', 'IQ'), // Default to Iraq if not found
      );
      countryCode = countryEntry.key;
      flagIsoCode = countryEntry.value;
    } catch (e) {
      countryCode = '+964';
      flagIsoCode = 'IQ';
    }
  }

  bool isNumeric(String? str) {
    if (str == null) return false;
    return RegExp(r'^[0-9]+$').hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.sizeOf(context).width * 0.9,
      child: IntlPhoneField(
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction,
        onSubmitted: widget.onFieldSubmitted,
        pickerDialogStyle: PickerDialogStyle(
          // width: MediaQuery.sizeOf(context).width * 0.6,
          backgroundColor: AppColors.grayscaleBackground,
          searchFieldInputDecoration: InputDecoration(
            hintText: 'ابحث عن الدولة...',
            hintStyle: AppTextStyles.medium16.copyWith(
              color: const Color(0xff71717A),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.grayscaleBorder,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        controller: widget.controller,
        initialCountryCode: widget.initialCountryCode,
        onCountryChanged: (value) {
          setState(() {
            countryCode = '+${value.dialCode}';
            flagIsoCode = value.code;
            if (widget.onCountryChanged != null) {
              widget.onCountryChanged!(countryCode);
            }
          });
        },
        onChanged: (phone) {
          final raw = phone.completeNumber;
          final code = countryCode.replaceAll(' ', '').replaceAll('-', '');
          final cleaned = raw.replaceFirst(
            RegExp('^\\+?${RegExp.escape(code)}[\\s-]*'),
            '',
          );
          if (widget.controller != null && widget.controller!.text != cleaned) {
            widget.controller!.text = cleaned;
            widget.controller!.selection = TextSelection.collapsed(
              offset: cleaned.length,
            );
          }
          // setState(() {
          //   _isTyping = cleaned.isNotEmpty;
          //   if (!isNumeric(cleaned)) {
          //     _errorMessage = 'من فضلك ادخل أرقام فقط';
          //   } else {
          //     _errorMessage = null;
          //   }
          // });
        },
        enabled: widget.enabled,
        textAlign: TextAlign.right,
        style: AppTextStyles.medium16.copyWith(color: const Color(0xff71717A)),
        flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 16),
        showDropdownIcon: false,
        invalidNumberMessage: 'الرجاء إدخال رقم هاتف صحيح',
        keyboardType: widget.keyboardType ?? TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.singleLineFormatter,
          if (widget.maxLength != null)
            LengthLimitingTextInputFormatter(widget.maxLength!),
        ],
        decoration: InputDecoration(
          prefixIcon: SvgPicture.asset(AppAssets.callIcon),
          filled: true,
          hoverColor: Colors.transparent,
          fillColor: AppColors.white,
          hintText: widget.hintText ?? 'رقم الهاتف...',
          hintStyle:
              widget.hintStyle ??
              AppTextStyles.medium16.copyWith(color: const Color(0xff71717A)),
          counterText: widget.maxLength != null ? '' : null,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: AppColors.grayscaleBorder,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.primary1, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red, width: 1.0),
          ),
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          errorMaxLines: 3,
          errorText: _errorMessage,
        ),
        validator: (phoneNumber) => widget.validator?.call(phoneNumber?.number),
      ),
    );
  }
}
