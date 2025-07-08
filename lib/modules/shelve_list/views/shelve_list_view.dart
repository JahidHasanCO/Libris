import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/modules/shelve_entry/shelve_entry.dart';
import 'package:libris/router/router.dart';
import 'package:libris/shared/enums/menu.dart';
import 'package:libris/shared/widgets/widgets.dart';

class ShelveListView extends ConsumerWidget {
  const ShelveListView({super.key});

  static List<Menu> filterMenus = [
    Menu.edit,
    Menu.delete,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Shelves',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: ProviderSelector(
          provider: shelveListProvider,
          selector: (s) => s.shelveList.isEmpty,
          builder: (context, isEmpty) {
            return isEmpty ? _emptyOrLoadingBody(ref) : _body(ref);
          },
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'shelve_add',
          onPressed: () async {
            await ShelveEntryBottomSheet.show(context);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(shelveListProvider.notifier).onRefresh();
            });
          },
          elevation: 0,
          backgroundColor: primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _emptyOrLoadingBody(WidgetRef ref, {bool isLoading = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 250,
          child: Stack(
            children: [
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Image.asset(
                    'assets/images/empty_book.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Blur filter
              Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Image.asset(
                        'assets/images/empty_book.png',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 200,
                        errorBuilder: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'No Shelves found',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _body(WidgetRef ref) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: Image.asset(
              'assets/images/empty_book.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: ColoredBox(
            color: backgroundColor.withAlpha(200),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ProviderSelector(
                provider: shelveListProvider,
                selector: (s) => s.shelveList,
                builder: (context, shelveList) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                    itemCount: shelveList.length,
                    itemBuilder: (context, index) {
                      final shelve = shelveList[index];
                      return ShelveCard(
                        title: shelve.name,
                        menuItems: filterMenus,
                        onTap: () {
                          context.pushNamed(
                            Routes.shelveDetails,
                            pathParameters: {
                              'id': shelve.id.toString(),
                            },
                          );
                        },
                        onMenuSelected: (index) async {
                          if (filterMenus[index] == Menu.edit) {
                            await ShelveEntryBottomSheet.show(
                              context,
                              isUpdate: true,
                              entry: shelve,
                            );
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ref.read(shelveListProvider.notifier).onRefresh();
                            });
                          }
                          if (filterMenus[index] == Menu.delete) {
                            await ref
                                .read(shelveListProvider.notifier)
                                .deleteShelve(shelve.id ?? 0);
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
