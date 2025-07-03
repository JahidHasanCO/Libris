import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/modules/onboard/onboard.dart';
import 'package:pdf_reader/shared/models/onboard.dart';

class OnboardProvider extends AutoDisposeNotifier<OnboardState> {
  @override
  OnboardState build() {
    return OnboardState(onboardList: _onboardList);
  }

  final _onboardList = [
    const Onboard(
      title: 'Read PDFs Easily',
      description: 'Open and read your PDFs with smooth performance.',
      path: 'assets/images/books.png',
    ),
    const Onboard(
      title: 'Organize Your Books',
      description: 'Manage all your PDFs and books in one place effortlessly.',
      path: 'assets/images/shelf.png',
    ),
    const Onboard(
      title: 'Track Reading Progress',
      description: 'Know what you have read and where you left off anytime.',
      path: 'assets/images/track.png',
    ),
  ];

  void changePage(int index) => state = state.copyWith(currentIndex: index);
}
