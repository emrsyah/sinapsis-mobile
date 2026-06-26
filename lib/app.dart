import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';

class SinapsisApp extends ConsumerWidget {
  const SinapsisApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Sinapsis',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
    );
  }

  ThemeData _buildTheme() {
    // Palette — near-black canvas, layered dark surfaces, mint accent.
    const bg = Color(0xFF000000);
    const surface = Color(0xFF161616); // cards
    const surfaceHigh = Color(0xFF1E1E1E); // chips, sheets
    const border = Color(0xFF262626); // hairline borders
    const mint = Color(0xFF34D399); // primary accent / FAB
    const onMint = Color(0xFF06140E);
    const textPrimary = Color(0xFFF5F5F5);
    const textMuted = Color(0xFF8A8A8A);

    final scheme =
        ColorScheme.fromSeed(
          seedColor: mint,
          brightness: Brightness.dark,
        ).copyWith(
          primary: mint,
          onPrimary: onMint,
          surface: bg,
          onSurface: textPrimary,
          onSurfaceVariant: textMuted,
          surfaceContainerLowest: bg,
          surfaceContainerLow: surface,
          surfaceContainer: surface,
          surfaceContainerHigh: surfaceHigh,
          surfaceContainerHighest: const Color(0xFF242424),
          outline: border,
          outlineVariant: const Color(0xFF1C1C1C),
        );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: bg,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: border),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF1C1C1C),
        thickness: 1,
        space: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: mint,
        foregroundColor: onMint,
        elevation: 6,
        focusElevation: 6,
        hoverElevation: 8,
        highlightElevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceHigh,
        side: const BorderSide(color: border),
        shape: const StadiumBorder(),
        labelStyle: const TextStyle(
          color: textPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: textMuted,
        textColor: textPrimary,
        selectedColor: mint,
        selectedTileColor: const Color(0x1A34D399),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xFF0D0D0D),
        surfaceTintColor: Colors.transparent,
        scrimColor: Color(0x99000000),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: const TextStyle(color: textMuted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: mint, width: 1.5),
        ),
      ),
      iconTheme: const IconThemeData(color: textPrimary),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: mint,
        selectionHandleColor: mint,
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: surfaceHigh,
        contentTextStyle: TextStyle(color: textPrimary),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: surfaceHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: border),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xFF111111),
        surfaceTintColor: Colors.transparent,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: mint,
          foregroundColor: onMint,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            fontFamily: 'Inter',
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: mint,
          foregroundColor: onMint,
          elevation: 0,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          side: const BorderSide(color: border),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: mint,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: surfaceHigh,
          selectedForegroundColor: textPrimary,
          foregroundColor: textMuted,
          side: const BorderSide(color: border),
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
        fontFamily: 'Inter',
      ),
    );
  }
}
