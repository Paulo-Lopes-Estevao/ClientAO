import 'package:client_ao/src/modules/home/states/collections.state.dart';
import 'package:client_ao/src/shared/utils/functions.utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';

class RequestBody extends HookConsumerWidget {
  const RequestBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeId = ref.watch(activeIdProvider);
    final defaultValue = ref.watch(collectionsNotifierProvider.notifier).getCollection()?.requests?[activeId?.requestId ?? 0]?.body;
    final bodyController = useTextEditingController(
      text: formatBody(defaultValue, MediaType('text', 'json')),
    );

    return TextField(
      controller: bodyController,
      keyboardType: TextInputType.multiline,
      minLines: 30,
      maxLines: 80,
      decoration: const InputDecoration(contentPadding: EdgeInsets.all(8)),
      onChanged: (value) {
        ref.read(collectionsNotifierProvider.notifier).updateRequest(body: value);
      },
    );
  }
}
