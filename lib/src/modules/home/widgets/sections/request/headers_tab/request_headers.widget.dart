import 'package:client_ao/src/modules/home/states/collections.state.dart';
import 'package:client_ao/src/shared/models/key_value_row.model.dart';
import 'package:client_ao/src/shared/utils/tables.utils.dart';
import 'package:davi/davi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RequestHeaders extends HookConsumerWidget {
  const RequestHeaders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeId = ref.watch(activeIdProvider);
    final index = ref.watch(collectionsNotifierProvider.notifier).indexOfId();
    final rows = ref.watch(collectionsNotifierProvider)[index].requests?[activeId?.requestId ?? 0]?.headers;
    List<_HeadersButtons>? buttons;

    useEffect(
      () {
        buttons = [
          _HeadersButtons(
            label: 'Add',
            onTap: () {
              rows?.add(const KeyValueRow());
              ref.read(collectionsNotifierProvider.notifier).updateRequest(headers: rows);
            },
          ),
          _HeadersButtons(
            label: 'Remove All',
            onTap: () {
              ref.read(collectionsNotifierProvider.notifier).removeAllHeaders();
            },
          ),
        ];
        return;
      },
    );

    final daviModel = createDaviTable(
      rows: rows,
      keyColumnName: 'Headers',
      valueColumnName: 'Values',
      context: context,
      onRemoveTaped: (index) {
        ref.read(collectionsNotifierProvider.notifier).removeHeader(index);
      },
      onFieldsChange: (newRows) {
        ref.read(collectionsNotifierProvider.notifier).updateRequest(headers: newRows);
      },
    );

    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: buttons?.length,
            itemBuilder: (BuildContext context, int index) {
              return TextButton(
                onPressed: buttons?[index].onTap,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
                ),
                child: Text('${buttons?[index].label}'),
              );
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Davi<KeyValueRow>(
              key: Key('${activeId?.requestId}-${rows?.length}'),
              daviModel,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeadersButtons {
  final String label;
  final VoidCallback? onTap;

  _HeadersButtons({required this.label, this.onTap});
}
