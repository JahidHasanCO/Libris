import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart' show CustomTransitionPage, GoRoute;
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/modules/pdf_add/pdf_add.dart';
import 'package:pdf_reader/router/router.dart' show AsPathExt, Routes;

class PdfAddPage extends ConsumerStatefulWidget {
  const PdfAddPage({super.key});

  static final route = GoRoute(
    path: Routes.pdfAdd.asPath,
    name: Routes.pdfAdd,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const PdfAddPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    ),
  );

  @override
  PdfAddPageState createState() => PdfAddPageState();
}

class PdfAddPageState extends ConsumerState<PdfAddPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(pdfAddProvider.notifier).import();
    });
  }

  void _listen() {
    ref
      ..listen(pdfAddProvider.select((s) => s.isBottomSheetOpen), (
        previous,
        next,
      ) {
        if (previous != next && next) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const PdfAddView(),
              ),
            ).then((value) {
              if (ref.context.mounted && Navigator.of(ref.context).canPop()) {
                Navigator.of(ref.context).pop();
              }
            });
          });
        }
      })
      ..listen(pdfAddProvider, (previous, next) {
        if (next.status.isError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.message)),
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    _listen();
    return const Scaffold(
      body: Center(
        child: Text('Importing PDF files...'),
      ),
    );
  }
}
