import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/modules/menu/menu.dart';
import 'package:pdf_reader/router/router.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: primaryColor,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      children: [
        MenuCard(
          icon: Symbols.folder_managed,
          title: 'Private Folder',
          description: 'Manage your private folder',
          trailing: const Icon(Symbols.arrow_forward_ios, size: 16),
          onTap: () => context.pushNamed(Routes.privateFolderPin),
        ),
        const SizedBox(height: 10),
        MenuCard(
          icon: Symbols.sunny,
          title: 'Ebook Theme',
          description: 'Change the ebook reader theme (light/dark)',
          trailing: const Icon(Symbols.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        const SizedBox(height: 10),
        MenuCard(
          icon: Symbols.person,
          title: 'About Us',
          description: 'Learn more about the app and its features',
          trailing: const Icon(Symbols.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
      ],
    );
  }
}
