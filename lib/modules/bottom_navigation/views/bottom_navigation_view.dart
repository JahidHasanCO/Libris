import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/modules/bottom_navigation/bottom_navigation.dart';
import 'package:pdf_reader/modules/home/home.dart';
import 'package:pdf_reader/modules/settings/settings.dart';

class BottomNavigationView extends ConsumerStatefulWidget {
  const BottomNavigationView({super.key});

  @override
  OnboardViewState createState() => OnboardViewState();
}

class OnboardViewState extends ConsumerState<BottomNavigationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _body(),
    );
  }

  Widget _body() {
    final selectedIndex = ref.watch(bottomNavigationProvider);
    return Stack(
      children: [
        Positioned.fill(
          child: IndexedStack(
            index: ref.watch(bottomNavigationProvider),
            children: const [
              HomeView(),
              SizedBox.shrink(),
              SettingsView(),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                if (index == 1) {
                  // Add button tapped – perform your action here
                  _onAddButtonTapped(context);
                } else {
                  // Change page index for Home and Settings only
                  ref.read(bottomNavigationProvider.notifier).setIndex(index);
                }
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
                    icon: Icons.add,
                    isAddButton: true,
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
          ),
        ),
      ],
    );
  }

  void _onAddButtonTapped(BuildContext context) {
    // Example action: show bottom sheet
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => const SizedBox(
        height: 200,
        child: Center(child: Text('Add Action Here')),
      ),
    );
  }
}
