import 'package:client_ao/src/core/models/key_value_row.model.dart';
import 'package:client_ao/src/modules/home/states/collections.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KeyTextField extends HookConsumerWidget {
  const KeyTextField({
    super.key,
    required this.index,
    this.keyFieldHintText,
    this.onKeyFieldChanged,
    this.rows,
    required this.row,
  });

  final int index;
  final String? keyFieldHintText;
  final Function(List<KeyValueRow>?)? onKeyFieldChanged;
  final List<KeyValueRow>? rows;
  final KeyValueRow row;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerController = useTextEditingController(text: row.key);

    return TextField(
      controller: headerController,
      decoration: InputDecoration(hintText: keyFieldHintText ?? 'key'),
      onChanged: (key) {
        List<KeyValueRow> newRows = rows ?? [];

        newRows = [
          ...newRows.sublist(0, index),
          row.copyWith(key: key),
          ...newRows.sublist(index + 1),
        ];

        if (onKeyFieldChanged != null) {
          onKeyFieldChanged?.call(newRows);
          return;
        }

        ref.read(collectionsNotifierProvider.notifier).updateRequest(headers: newRows);
      },
    );
  }
}
