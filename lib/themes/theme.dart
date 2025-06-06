import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true, // إضافة دعم Material 3
      brightness: Brightness.light,
      primaryColor: Colors.blue.shade700,
      scaffoldBackgroundColor: Colors.grey.shade100,
      colorScheme: ColorScheme.light(
        primary: Colors.blue.shade700,
        secondary: Colors.teal.shade400,
        surface: Colors.white,
        background: Colors.grey.shade100,
        error: Colors.red.shade600,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.grey.shade900,
        onBackground: Colors.grey.shade900,
        onError: Colors.white,
      ),
      fontFamily: 'Montserrat',

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue.shade700,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Montserrat',
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue.shade700,
          disabledForegroundColor: Colors.grey.shade400,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue.shade700,
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blue.shade700,
          side: BorderSide(color: Colors.blue.shade700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.teal.shade400, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade600),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red.shade600, width: 2),
        ),
        hintStyle: TextStyle(color: Colors.grey.shade500),
        labelStyle: TextStyle(color: Colors.blue.shade700),
        errorStyle: TextStyle(color: Colors.red.shade600),
        floatingLabelStyle: TextStyle(color: Colors.teal.shade400),
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        surfaceTintColor: Colors.white,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        displaySmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        headlineSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        titleMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.black54,
          fontFamily: 'Montserrat',
        ),
        labelLarge: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
          fontFamily: 'Montserrat',
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.black87,
          fontFamily: 'Montserrat',
        ),
        labelSmall: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: Colors.black54,
          fontFamily: 'Montserrat',
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.blue.shade700,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actionTextColor: Colors.teal.shade200,
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.shade400;
          }
          return Colors.blue.shade700;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: Colors.grey.shade600, width: 1.5),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.shade700;
          }
          return Colors.grey.shade50;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.shade300;
          }
          return Colors.grey.shade400;
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.shade700;
          }
          return Colors.grey.shade600;
        }),
      ),

      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.shade700;
          }
          return Colors.grey.shade600;
        }),
      ),

      dividerTheme: DividerThemeData(
        color: Colors.grey.shade400,
        thickness: 1,
        space: 1,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.blue.shade700,
        linearTrackColor: Colors.grey.shade300,
        circularTrackColor: Colors.grey.shade300,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey.shade600,
        elevation: 8,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          fontFamily: 'Montserrat',
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
          fontFamily: 'Montserrat',
        ),
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        elevation: 8,
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: Colors.blue.shade700,
        unselectedLabelColor: Colors.grey.shade600,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          fontFamily: 'Montserrat',
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          fontFamily: 'Montserrat',
        ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
        ),
      ),
    );
  }

  // يمكنك إضافة ثيم داكن هنا إذا أردت
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      // إعدادات الثيم الداكن
    );
  }
}
