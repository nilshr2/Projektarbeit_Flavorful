library flavorful.constants;

import 'package:flutter/material.dart';

// Colors
const kPrimary = Color(0xFFF9814E); //FF277da1
const kSecondary = Color(0xFFf8961e);
const kAccent = Color(0xFF577590);
const kOutline = Color(0xFFEAF0F2);
const kWhite = Color(0xFFFFFFFF);
const kBlack = Color(0xFF000000);
const kDarken = Color(0x58000000);

// Border Radius
const kSmallBorderRad = BorderRadius.all(Radius.circular(16));
const kNormalBorderRad = BorderRadius.all(Radius.circular(24));
const kNormalBorderRadTop = BorderRadius.vertical(top: Radius.circular(24));
const kNormalBorderRadBottom =
    BorderRadius.vertical(bottom: Radius.circular(24));
const kLargeBorderRadVert = BorderRadius.vertical(top: Radius.circular(32));
const kLargeBorderRad = BorderRadius.all(Radius.circular(32));

const kCategoryCardRad = BorderRadius.only(
    topLeft: Radius.circular(75),
    bottomLeft: Radius.circular(75),
    topRight: Radius.circular(24),
    bottomRight: Radius.circular(24));
const kCategoryCardImageRad = BorderRadius.all(Radius.circular(75));

//Edge Insets
const kTextSpacingInset = 4.0;
const kButtonInset = 12.0;
const kSmallInset = 8.0;
const kNormalInset = 16.0;
const kLargeInset = 32.0;

// Text Styles
const kAppBarTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: kBlack);
const kSubAppBarTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: kAccent);
const kDropdownSelectedEntryStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: kAccent);
const kDropdownEntryStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: kAccent);
const kButtonStyleBlack = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: kBlack);
const kButtonStyleWhite = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: kWhite);

const kH1TitleStyleWhite = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: kWhite);
const kH1TitleStyleBlack = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: kBlack);
const kH1TitleStyleWhiteBold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: kWhite);
const kH1TitleStyleBlackBold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: kBlack);
const kH1TitleStylePrimaryBold = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: kPrimary);
const kH2TitleStyleWhite = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: kWhite);
const kH2TitleStyleBlack = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: kBlack);
const kH3TitleStyleWhite = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: kWhite);
const kH3TitleStyleBlack = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: kBlack);

//BorderSide
const kOutlineBorderSide = BorderSide(color: kOutline, width: 1);
const kSmallImageBorderSide = BorderSide(color: kWhite, width: 4);
const kLargeImageBorderSide = BorderSide(color: kWhite, width: 8);

//Border
const kOutlineBorder = Border(
    top: kOutlineBorderSide,
    bottom: kOutlineBorderSide,
    left: kOutlineBorderSide,
    right: kOutlineBorderSide);

const kLargeImageBorder = Border(
    top: kLargeImageBorderSide,
    bottom: kLargeImageBorderSide,
    left: kLargeImageBorderSide,
    right: kLargeImageBorderSide);

const kSmallImageBorder = Border(
    top: kSmallImageBorderSide,
    bottom: kSmallImageBorderSide,
    left: kSmallImageBorderSide,
    right: kSmallImageBorderSide);

//Box Shadow
const kNormalBoxShadow = BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 20,
    spreadRadius: 0,
    color: Color(0x1f000000));

//Box Decoration
const kDropdownOuterContainerDecoration = BoxDecoration(
    color: kWhite,
    borderRadius: kSmallBorderRad,
    border: kOutlineBorder,
    boxShadow: [kNormalBoxShadow]);

const kDropdownInnerContainerDecoration = BoxDecoration(
  color: kWhite,
  borderRadius: kSmallBorderRad,
  border: kOutlineBorder,
);

//CircularProgressIndicator Style
const kSmallCircularProgressIndicator = SizedBox.square(
  dimension: 16,
  child: CircularProgressIndicator.adaptive(
    strokeWidth: 3,
  ),
);

const kNormalCircularProgressIndicator = SizedBox.square(
  dimension: 48,
  child: CircularProgressIndicator.adaptive(),
);
