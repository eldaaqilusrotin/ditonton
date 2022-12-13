import 'package:flutter/material.dart';

const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';

///colors
const Color kRichBlack = Color(0xFF000814);
const Color kFordBlue = Color(0xFF001D3D);
const Color kPrussianBlue = Color(0xFF003566);
const Color kYellow = Color(0xFFffc300);
const Color Grey = Color(0xFF4b5358);
const Color kGrey = Color(0xFF303030);


const kColorScheme = ColorScheme(
    primary: kYellow,
    secondary: kPrussianBlue,
    surface: kRichBlack,
    background: kRichBlack,
    error: Colors.red,
    onPrimary: kRichBlack,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark
);