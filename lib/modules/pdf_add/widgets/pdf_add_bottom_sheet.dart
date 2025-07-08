import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/core/utils/extension/ref.dart';
import 'package:libris/shared/models/models.dart';
import 'package:libris/shared/validators/validators.dart';
import 'package:libris/shared/widgets/filled_outlined_dropdown_form_field.dart';
import 'package:libris/shared/widgets/filled_outlined_text_field.dart';
import 'package:libris/shared/widgets/rounded_button.dart';

class PdfAddBottomSheet extends ConsumerStatefulWidget with PdfValidator {
  const PdfAddBottomSheet({required this.isUpdate, this.entry, super.key});

  final bool isUpdate;
  final CategoryPDF? entry;

  static Future<void> show(
    BuildContext context, {
    bool isUpdate = false,
    CategoryPDF? entry,
  }) async {
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
        child: PdfAddBottomSheet(
          isUpdate: isUpdate,
          entry: entry,
        ),
      ),
    );
  }

  @override
  PdfAddViewState createState() => PdfAddViewState();
}

class PdfAddViewState extends ConsumerState<PdfAddBottomSheet> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate && widget.entry != null) {
      titleController.text = widget.entry!.name ?? '';
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final categoryList = ref.read(appProvider).categories;
        for (final category in categoryList) {
          if (category.id == widget.entry!.categoryId) {
            selectedCategory = category;
            break;
          }
        }
        ref.read(pdfAddProvider.notifier).onCategoryChanged(selectedCategory);
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
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
              Expanded(
                child: Text(
                  widget.isUpdate ? 'Update PDF' : 'Add PDF',
                  style: const TextStyle(
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
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FilledOutlinedTextField(
                  controller: titleController,
                  label: 'Title',
                  hint: 'Enter PDF title',
                  keyboardType: TextInputType.text,
                  validator: widget.validateTitle,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer(
                  builder: (context, ref, child) {
                    final categories = ref.select(
                      appProvider,
                      (s) => s.categories,
                    );
                    final selectedCategory = ref.select(
                      pdfAddProvider,
                      (s) => s.selectedCategory,
                    );
                    return FilledOutlinedDropdownFormField<int?>(
                      label: 'Category',
                      value: selectedCategory?.id,
                      onChanged: (value) {
                        if (value == null) return;
                        Category? category;
                        for (final c in categories) {
                          if (c.id == value) {
                            category = c;
                            break;
                          }
                        }
                        ref
                            .read(pdfAddProvider.notifier)
                            .onCategoryChanged(category);
                      },
                      items: categories
                          .map(
                            (c) => DropdownMenuItem<int?>(
                              value: c.id,
                              child: Text(c.name),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RoundedButton(
            minimumSize: const Size(double.infinity, 50),
            onPressed: () async {
              if (!_formKey.currentState!.validate()) return;
              final title = titleController.text.trim();
              await ref
                  .read(pdfAddProvider.notifier)
                  .updatePdf(
                    title,
                    widget.entry,
                  );
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            title: widget.isUpdate ? 'Update' : 'Save',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
