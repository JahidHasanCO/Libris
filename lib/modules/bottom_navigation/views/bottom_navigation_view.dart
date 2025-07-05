import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/modules/bottom_navigation/bottom_navigation.dart';
import 'package:pdf_reader/modules/home/home.dart';
import 'package:pdf_reader/modules/settings/settings.dart';
import 'package:pdf_reader/router/router.dart';

class BottomNavigationView extends ConsumerStatefulWidget {
  const BottomNavigationView({super.key});

  @override
  OnboardViewState createState() => OnboardViewState();
}

class OnboardViewState extends ConsumerState<BottomNavigationView> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(Routes.pdfAdd);
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
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
              icon: Icons.home,
              isSelected: selectedIndex == 0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: NavItem(
              icon: Icons.view_list,
              isSelected: selectedIndex == 1,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: NavItem(
              icon: Icons.settings,
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
        SettingsView(),
        SettingsView(),
      ],
    );
  }
}
