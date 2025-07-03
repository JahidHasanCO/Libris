
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/modules/onboard/onboard.dart';
import 'package:pdf_reader/shared/widgets/widgets.dart';

class OnboardView extends ConsumerStatefulWidget {
  const OnboardView({super.key});

  @override
  OnboardViewState createState() => OnboardViewState();
}

class OnboardViewState extends ConsumerState<OnboardView> {
  late final PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
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
            constraints: BoxConstraints(maxHeight: height * 0.60),
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
        const SizedBox(height: 40),
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
                          : greyColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: height * 0.10),
        Padding(
          padding: const EdgeInsets.all(20),
          child: RoundedButton(
            onPressed: () {},
            title: 'Get Started',
            minimumSize: const Size(double.infinity, 52),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
