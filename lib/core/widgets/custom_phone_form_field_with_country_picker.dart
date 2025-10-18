import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_finder_app/config/theme/app_colors.dart';
import 'package:pet_finder_app/config/theme/app_style.dart';
import 'package:pet_finder_app/core/widgets/custom_text_form_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';

class PhoneNumberWithCountryPicker extends StatelessWidget {
  const PhoneNumberWithCountryPicker({
    super.key,
    required this.country,
    required this.phoneController,
    required this.changeCountry,
    this.enableHeader = true,
    this.validator,
    this.backgroundColor,
    this.textStyle,
    this.isSuffix = false,
  });
  final Country country;
  final TextEditingController phoneController;
  final void Function(Country) changeCountry;
  final bool enableHeader;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool isSuffix;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      keyboardType: TextInputType.phone,
      controller: phoneController,
      maxLength: country.maxLength,
      headerText: enableHeader ? "رقم الهاتف".tr() : null,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator:
          validator ??
          (value) {
            if ((country.dialCode == '964' || country.dialCode == '20') &&
                phoneController.text.trim().isEmpty) {
              return "يرجي ادخال رقم الهاتف".tr();
            } else if (value != null &&
                value.isNotEmpty &&
                value.startsWith('0')) {
              return "رقم الهاتف يبدأ بصفر".tr();
            } else if (value == null ||
                value.isEmpty ||
                value.length < country.maxLength) {
              return "رقم الهاتف غير صحيح".tr();
            }
            return null;
          },
      // spacing: 8,
      prefixIcon: !isSuffix
          ? BtnShape(country: country, changeCountry: changeCountry)
          : null,
      suffixIcon: isSuffix
          ? BtnShape(country: country, changeCountry: changeCountry)
          : null,
      hintText: "ادخل رقم الهاتف".tr(),
      hintStyle: AppTextStyles.regular16.copyWith(color: AppColors.textSubtle),
      obscureText: false,
      // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}

class BtnShape extends StatelessWidget {
  const BtnShape({
    super.key,
    required this.country,
    required this.changeCountry,
  });

  final Country country;
  final void Function(Country p1) changeCountry;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          useRootNavigator: false,
          barrierDismissible: true,
          builder: (context) => CountryPickerDialog(
            languageCode: context.locale.languageCode,
            filteredCountries: countries,
            searchText: "",
            countryList: countries,
            selectedCountry: country,
            style: PickerDialogStyle(
              searchFieldPadding: const EdgeInsets.all(0),

              searchFieldInputDecoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "بحث".tr(),

                labelStyle: AppTextStyles.regular14.copyWith(
                  color: AppColors.black,
                ),
              ),
              backgroundColor: AppColors.white,
              countryNameStyle: AppTextStyles.semiBold14,
            ),
            onCountryChanged: changeCountry,
          ),
        );
      },
      padding: const EdgeInsetsDirectional.only(start: 12),
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary50,
          borderRadius: BorderRadius.circular(6),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(country.flag, style: AppTextStyles.regular14),
            // const SizedBox(width: 4),
            Text(
              "${country.fullCountryCode}+",
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.primary1,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.keyboard_arrow_down_sharp,
              color: AppColors.primary1,
            ),
            // const SizedBox(
            //   height: 40,
            //   child: VerticalDivider(thickness: 1, color: AppColors.zinc200),
            // ),
          ],
        ),
      ),
    );
  }
}
