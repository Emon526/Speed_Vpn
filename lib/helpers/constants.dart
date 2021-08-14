import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'size_config.dart';

const String kImageDir = 'assets/images/';
const String kImageUrl = 'assets/images/logo.png';

const kPrimaryColor = Color(0xFF56278F);
const kSecondaryColor = Color(0xFFFFC220);
const kBlackColor = Colors.black;
const kWhiteColor = Colors.white;
const kSuccessColor = Color(0xFF2EB843);
const kErrorColor = Colors.red;
const kDarkColor = Color(0xFF1E1F28);
final kBgColorDisconnected = [Color(0xFF000000), Color(0xFFDD473D)];
final kBgColorConnected = [Color(0xFF000000), Color(0xFF37AC53)];
final kBgColorConnecting = [Color(0xFF000000), Color(0xFFCCAD00)];

final kHeadLine = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(34.0),
  fontWeight: FontWeight.w700,
  height: 1.25,
);
final kHeadLineTest = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(34.0),
  fontWeight: FontWeight.w700,
  height: 1.25,
);
final kHeadLine2 = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(24.0),
  fontWeight: FontWeight.w600,
  height: 1.25,
);
final kHeadLine3 = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(22.0),
  fontWeight: FontWeight.w500,
  height: 1.25,
);
final kHeadLine4 = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(18.0),
  fontWeight: FontWeight.w500,
  height: 1.25,
);
final kRegularText = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(16.0),
  fontWeight: FontWeight.w400,
  height: 1.25,
);
final kDescriptionText = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(14.0),
  fontWeight: FontWeight.w400,
  height: 1.25,
);
final kDescriptionText2 = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(12.0),
  fontWeight: FontWeight.w400,
  height: 1.25,
);
final kSmallText = TextStyle(
  fontFamily: GoogleFonts.roboto().fontFamily,
  fontSize: getProportionateScreenWidth(11.0),
  fontWeight: FontWeight.w400,
  height: 1.25,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmptyError = "Required field can't be empty";
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter valid Email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "Please enter your name";
const String kPhoneNumberNullError = "Please enter your phone number";
const String kAddressNullError = "Please enter your address";
