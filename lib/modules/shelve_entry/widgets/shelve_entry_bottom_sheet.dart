import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libris/core/provider/provider.dart';
import 'package:libris/core/theme/colors.dart';
import 'package:libris/shared/models/models.dart';
import 'package:libris/shared/validators/validators.dart';
import 'package:libris/shared/widgets/filled_outlined_text_field.dart';
import 'package:libris/shared/widgets/rounded_button.dart';

class ShelveEntryBottomSheet extends ConsumerStatefulWidget
    with ShelveValidator {
  const ShelveEntryBottomSheet({
    required this.isUpdate,
    this.entry,
    super.key,
  });

  final bool isUpdate;
  final Shelf? entry;

  static Future<void> show(
    BuildContext context, {
    bool isUpdate = false,
    Shelf? entry,
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
        child: ShelveEntryBottomSheet(
          isUpdate: isUpdate,
          entry: entry,
        ),
      ),
    );
  }

  @override
  ShelveEntryBottomSheetState createState() => ShelveEntryBottomSheetState();
}

class ShelveEntryBottomSheetState
    extends ConsumerState<ShelveEntryBottomSheet> {
  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.isUpdate && widget.entry != null){
      titleController.text = widget.entry!.name;
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
              const Expanded(
                child: Text(
                  'Add Shelve',
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
                  label: 'Name',
                  hint: 'Enter Shelve Name',
                  keyboardType: TextInputType.text,
                  validator: widget.validateTitle,
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
              await ref.read(shelveEntryProvider.notifier).add(title);
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
