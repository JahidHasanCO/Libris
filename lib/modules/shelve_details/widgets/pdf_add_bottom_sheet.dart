import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/string.dart';
import 'package:libris/shared/widgets/provider_selector.dart';
import 'package:libris/shared/widgets/rounded_button.dart';

class PdfAddBottomSheet extends ConsumerStatefulWidget {
  const PdfAddBottomSheet({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet<void>(
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
        child: const PdfAddBottomSheet(),
      ),
    );
  }

  @override
  ShelveEntryBottomSheetState createState() => ShelveEntryBottomSheetState();
}

class ShelveEntryBottomSheetState extends ConsumerState<PdfAddBottomSheet> {
  final List<int> selectedPdfIds = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(shelveDetailsProvider.notifier).onInsert();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Add Pdf Shelve',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, color: textColor, size: 24),
              ),
            ],
          ),
        ),
        ProviderSelector(
          provider: shelveDetailsProvider,
          selector: (state) => state.insertAblePdfList,
          builder: (context, pdfs) {
            return ListView.builder(
              itemCount: pdfs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final pdf = pdfs[index];
                final isSelected = selectedPdfIds.contains(pdf.id);
                return CheckboxListTile(
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value ?? false) {
                        selectedPdfIds.add(pdf.id!);
                      } else {
                        selectedPdfIds.remove(pdf.id);
                      }
                    });
                  },
                  title: Text(
                    pdf.name ?? 'Untitled',
                    style: const TextStyle(color: textColor),
                  ),
                  subtitle: Text(
                    pdf.updatedAt?.toDdMmYy() ?? 'Unknown Author',
                    style: const TextStyle(color: textColor),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: primaryColor,
                );
              },
            );
          },
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RoundedButton(
            minimumSize: const Size(double.infinity, 50),
            onPressed: () async {
              await ref
                  .read(shelveDetailsProvider.notifier)
                  .addPdfListToShelf(
                    selectedPdfIds,
                  );
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            title: 'Add to Shelve',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
