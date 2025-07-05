import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_reader/core/provider/provider.dart';
import 'package:pdf_reader/core/theme/colors.dart';
import 'package:pdf_reader/core/utils/extension/ref.dart';
import 'package:pdf_reader/shared/models/models.dart';
import 'package:pdf_reader/shared/validators/validators.dart';
import 'package:pdf_reader/shared/widgets/filled_outlined_dropdown_form_field.dart';
import 'package:pdf_reader/shared/widgets/filled_outlined_text_field.dart';
import 'package:pdf_reader/shared/widgets/rounded_button.dart';

class PdfAddView extends ConsumerStatefulWidget with PdfValidator {
  const PdfAddView({super.key});

  @override
  PdfAddViewState createState() => PdfAddViewState();
}

class PdfAddViewState extends ConsumerState<PdfAddView> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final title = ref.read(pdfAddProvider).title;
      titleController.text = title;
    });
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
              const Expanded(
                child: Text(
                  'Add PDF',
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
              await ref.read(pdfAddProvider.notifier).updatePdf(title);
              if (!context.mounted) return;
              Navigator.pop(context);
            },
            title: 'Save',
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
