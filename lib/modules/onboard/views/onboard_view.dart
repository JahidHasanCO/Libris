import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/ref.dart';
import 'package:libris/modules/onboard/onboard.dart';
import 'package:libris/router/router.dart';
import 'package:libris/shared/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardView extends ConsumerStatefulWidget {
  const OnboardView({super.key});

  @override
  OnboardViewState createState() => OnboardViewState();
}

class OnboardViewState extends ConsumerState<OnboardView> {
  late final PageController? pageController;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _prefs = await SharedPreferences.getInstance();
    });
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  Future<void> onNavigateToHome() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setBool('onboarded', true);
    if (!mounted) return;
    context.go(Routes.bottomNavigation.asPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _body(),
    );
  }

  Widget _body() {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final notifier = ref.read(onboardProvider.notifier);
    return Column(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height * 0.50),
            child: ProviderSelector(
              provider: onboardProvider,
              selector: (state) => state.onboardList,
              builder: (context, onboardList) {
                return PageView.builder(
                  controller: pageController,
                  itemCount: onboardList.length,
                  onPageChanged: notifier.changePage,
                  itemBuilder: (context, index) {
                    final onboard = onboardList[index];
                    return OnboardCard(onboard: onboard);
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        ProviderSelector(
          provider: onboardProvider,
          selector: (state) => state,
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                state.onboardList.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 6,
                    width: state.currentIndex == index ? 20 : 10,
                    decoration: BoxDecoration(
                      color: state.currentIndex == index
                          ? primaryColor
                          : textGrayColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Consumer(
          builder: (context, ref, child) {
            final currentIndex = ref.select(
              onboardProvider,
              (s) => s.currentIndex,
            );
            final totalPages = ref.select(
              onboardProvider,
              (s) => s.onboardList.length,
            );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: RoundedButton(
                      onPressed: () {
                        if (currentIndex == 0) return;
                        final prevPage = currentIndex - 1;
                        pageController?.animateToPage(
                          prevPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        notifier.changePage(prevPage);
                      },
                      title: 'Back',
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: textColor,
                      minimumSize: const Size(double.infinity, 52),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RoundedButton(
                      onPressed: () async {
                        if (currentIndex == totalPages - 1) {
                          await onNavigateToHome();
                        } else {
                          final nextPage = currentIndex + 1;
                          await pageController?.animateToPage(
                            nextPage,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          notifier.changePage(nextPage);
                        }
                      },
                      title: 'Next',
                      minimumSize: const Size(double.infinity, 52),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
