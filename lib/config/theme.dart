//https://dribbble.com/shots/6685644-Sign-In-Immdrops-App/attachments/6685644-Sign-In-Immdrops-App?mode=media

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Definindo a cor semente (Seed Color)
// const Color _seedColor = Color(0xFF0D47A1); // Um azul escuro e profissional

/// Retorna o Tema Claro (Light Theme) detalhado para o app.
// ThemeData getDetailedLightTheme() {
//   // 1. Gerar a paleta de cores base do Material 3
//   final colorScheme = ColorScheme.fromSeed(
//     seedColor: _seedColor,
//     brightness: Brightness.light,
//
//     // [Opcional] Sobreposições manuais para maior controle
//     background: const Color(0xFFFAFAFA),
//     // Um fundo cinza muito claro (quase branco)
//     surface: Colors.white,
//     // Cor dos Cards e Dialogs
//     primary: _seedColor, // Força a cor primária a ser exatamente a semente
//   );
//
//   // 2. Definir a base da tipografia (TextTheme) usando Google Fonts
//   final textTheme =
//       GoogleFonts.interTextTheme(
//         ThemeData(brightness: Brightness.light).textTheme,
//       ).copyWith(
//         // Títulos de Seção (Ex: "Próximas Partidas")
//         headlineMedium: GoogleFonts.inter(
//           fontWeight: FontWeight.w700,
//           fontSize: 24,
//           color: colorScheme.onBackground, // Cor de texto sobre o fundo
//         ),
//         // Títulos de Card (Ex: "Brasil vs Argentina")
//         titleLarge: GoogleFonts.inter(
//           fontWeight: FontWeight.w700,
//           fontSize: 18,
//           color: colorScheme.onSurface, // Cor de texto sobre os cards
//         ),
//         // Subtítulos de Card (Ex: "Copa do Mundo - Final")
//         titleMedium: GoogleFonts.inter(
//           fontWeight: FontWeight.w500,
//           fontSize: 16,
//           color: colorScheme.onSurface.withOpacity(0.7), // Cor secundária
//         ),
//         // Corpo de texto principal
//         bodyMedium: GoogleFonts.inter(
//           fontSize: 14,
//           color: colorScheme.onSurface.withOpacity(0.8),
//         ),
//         // Texto de Botões
//         labelLarge: GoogleFonts.inter(
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//           letterSpacing: 0.5,
//         ),
//       );
//
//   // 3. Montar o ThemeData
//   return ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     colorScheme: colorScheme,
//     textTheme: textTheme,
//
//     // [Detalhes de Componentes]
//
//     // --- AppBar Theme ---
//     appBarTheme: AppBarTheme(
//       elevation: 0,
//       // Visual "flat" moderno
//       backgroundColor: colorScheme.primary,
//       // AppBar com a cor primária
//       foregroundColor: colorScheme.onPrimary,
//       // Ícones e texto brancos
//       titleTextStyle: textTheme.titleLarge?.copyWith(
//         color: colorScheme.onPrimary, // Título da AppBar branco
//         fontSize: 20,
//       ),
//       iconTheme: IconThemeData(
//         color: colorScheme.onPrimary, // Ícones (menu, voltar) brancos
//       ),
//     ),
//
//     // --- Card Theme (para as partidas) ---
//     cardTheme: CardThemeData(
//       elevation: 1.5,
//       // Sombra muito sutil
//       color: colorScheme.surface,
//       // Branco
//       shadowColor: Colors.black12,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//     ),
//
//     // --- ElevatedButton Theme (Ação Principal) ---
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: colorScheme.primary,
//         foregroundColor: colorScheme.onPrimary,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//         textStyle: textTheme.labelLarge,
//       ),
//     ),
//
//     // --- OutlinedButton Theme (Ação Secundária) ---
//     outlinedButtonTheme: OutlinedButtonThemeData(
//       style: OutlinedButton.styleFrom(
//         foregroundColor: colorScheme.primary,
//         side: BorderSide(
//           color: colorScheme.primary.withOpacity(0.5),
//           width: 1.5,
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//         textStyle: textTheme.labelLarge,
//       ),
//     ),
//
//     // --- TextButton Theme (Ação Terciária) ---
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: colorScheme.primary,
//         textStyle: textTheme.labelLarge,
//       ),
//     ),
//
//     // --- BottomNavigationBar Theme ---
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: Colors.white,
//       // Fundo branco
//       elevation: 8.0,
//       // Sombra para destacar do conteúdo
//       selectedItemColor: colorScheme.primary,
//       // Ícone/Texto selecionado
//       unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
//       // Ícone/Texto não selecionado
//       selectedLabelStyle: textTheme.labelLarge?.copyWith(fontSize: 12.0),
//       unselectedLabelStyle: textTheme.labelLarge?.copyWith(
//         fontSize: 12.0,
//         fontWeight: FontWeight.w500,
//       ),
//       type:
//           BottomNavigationBarType.fixed, // Garante que todos os itens apareçam
//     ),
//
//     // --- TabBar Theme (para "Jogos", "Notícias", "Classificação") ---
//     tabBarTheme: TabBarThemeData(
//       labelColor: colorScheme.primary,
//       unselectedLabelColor: colorScheme.onSurface.withOpacity(0.7),
//       indicatorColor: colorScheme.primary,
//       // Cor da linha indicadora
//       labelStyle: textTheme.labelLarge?.copyWith(fontSize: 14),
//       unselectedLabelStyle: textTheme.labelLarge?.copyWith(
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//     ),
//
//     // --- InputDecoration Theme (para Barras de Busca) ---
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.black.withOpacity(0.04),
//       // Cinza bem claro
//       contentPadding: const EdgeInsets.all(
//         12.0
//       ),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.0),
//         borderSide: BorderSide.none, // Sem borda por padrão
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.0),
//         borderSide: BorderSide.none,
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8.0),
//         borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
//       ),
//       hintStyle: textTheme.bodyMedium?.copyWith(
//         color: colorScheme.onSurface.withOpacity(0.5),
//       ),
//     ),
//
//     // --- FloatingActionButton Theme ---
//     floatingActionButtonTheme: FloatingActionButtonThemeData(
//       // O M3 gera uma cor "terciária" (tertiary) contrastante
//       // que será usada aqui (provavelmente um tom de amarelo/laranja)
//       backgroundColor: colorScheme.tertiaryContainer,
//       foregroundColor: colorScheme.onTertiaryContainer,
//       elevation: 4.0,
//     ),
//   );
// }

const Color _seedColorGreen = Color(0xFF2E7D32);

ThemeData getDetailedLightThemeGreen() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: _seedColorGreen,
    brightness: Brightness.light,

    surface: const Color(0xFFFAFAFA),
    primary: _seedColorGreen,
  );

  final textTheme =
      GoogleFonts.interTextTheme(
        ThemeData(brightness: Brightness.light).textTheme,
      ).copyWith(
        headlineMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: colorScheme.onSurface,
        ),
        titleLarge: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: colorScheme.onSurface,
        ),
        titleMedium: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: colorScheme.onSurface.withValues(alpha: 0.7),
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: colorScheme.onSurface.withValues(alpha: 0.8),
        ),
        labelLarge: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    textTheme: textTheme,

    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: colorScheme.onPrimary,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
    ),

    cardTheme: CardThemeData(
      elevation: 1.5,
      color: colorScheme.surface,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: textTheme.labelLarge,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(
          color: colorScheme.primary.withValues(alpha: 0.5),
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: textTheme.labelLarge,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 8.0,
      selectedItemColor: colorScheme.primary,
      unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
      selectedLabelStyle: textTheme.labelLarge?.copyWith(fontSize: 12.0),
      unselectedLabelStyle: textTheme.labelLarge?.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
      type: BottomNavigationBarType.fixed,
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: colorScheme.primary,
      unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.7),
      indicatorColor: colorScheme.primary,
      labelStyle: textTheme.labelLarge?.copyWith(fontSize: 14),
      unselectedLabelStyle: textTheme.labelLarge?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black.withValues(alpha: 0.04),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 14.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface.withValues(alpha: 0.5),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.tertiaryContainer,
      foregroundColor: colorScheme.onTertiaryContainer,
      elevation: 4.0,
    ),
  );
}
