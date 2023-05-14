import 'package:client_ao/src/modules/home/states/collections.state.dart';
import 'package:client_ao/src/shared/utils/client_ao_extensions.dart';
import 'package:client_ao/src/modules/home/widgets/sections/request/url_params_tab/url_preview.widget.dart';
import 'package:client_ao/src/shared/models/key_value_row.model.dart';
import 'package:client_ao/src/shared/utils/tables.utils.dart';
import 'package:davi/davi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RequestUrlParams extends HookConsumerWidget {
  const RequestUrlParams({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UrlPreview(),
        Expanded(child: _UrlParamsRowsList()),
      ],
    );
  }
}

class _UrlParamsRowsList extends HookConsumerWidget {
  const _UrlParamsRowsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeId = ref.watch(activeIdProvider);
    final index = ref.watch(collectionsNotifierProvider.notifier).indexOfId();
    final rows = ref.watch(collectionsNotifierProvider).get(index)?.requests?.get(activeId?.requestId)?.urlParams;

    List<_HeadersButtons>? buttons;

    useEffect(
      () {
        buttons = [
          _HeadersButtons(
            label: 'Add',
            onTap: () {
              rows?.add(const KeyValueRow());
              ref.read(collectionsNotifierProvider.notifier).updateRequest(urlParams: rows);
            },
          ),
          _HeadersButtons(
            label: 'Remove All',
            onTap: () {
              ref.read(collectionsNotifierProvider.notifier).removeAllUrlParams();
            },
          ),
        ];
        return;
      },
    );

    final daviModel = createDaviTable(
      rows: rows,
      keyColumnName: 'Keys',
      context: context,
      valueColumnName: 'Values',
      onFieldsChange: (newRows) {
        ref.read(collectionsNotifierProvider.notifier).updateRequest(urlParams: newRows);
      },
      onRemoveTaped: (index) {
        ref.read(collectionsNotifierProvider.notifier).removeUrlParam(index);
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
          child: Davi<KeyValueRow>(
            key: Key('${activeId?.requestId}-${rows?.length}'),
            daviModel,
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
