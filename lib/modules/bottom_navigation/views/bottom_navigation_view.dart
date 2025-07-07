import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/modules/bottom_navigation/bottom_navigation.dart';
import 'package:libris/modules/home/home.dart';
import 'package:libris/modules/menu/menu.dart';
import 'package:material_symbols_icons/symbols.dart';

class BottomNavigationView extends ConsumerStatefulWidget {
  const BottomNavigationView({super.key});

  @override
  BottomNavigationViewState createState() => BottomNavigationViewState();
}

class BottomNavigationViewState extends ConsumerState<BottomNavigationView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(homeProvider.notifier).onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    return Scaffold(
      body: _body(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(bottomNavigationProvider.notifier).setIndex(index);
        },
        backgroundColor: primaryColor.withAlpha(40),
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey.shade300,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: NavItem(
              icon: Symbols.home,
              isSelected: selectedIndex == 0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: NavItem(
              icon: Symbols.newsstand,
              isSelected: selectedIndex == 1,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: NavItem(
              icon: Symbols.menu,
              isSelected: selectedIndex == 2,
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return IndexedStack(
      index: ref.watch(bottomNavigationProvider),
      children: const [
        HomeView(),
        MenuView(),
        MenuView(),
      ],
    );
  }
}
