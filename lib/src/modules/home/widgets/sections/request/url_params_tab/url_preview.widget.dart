import 'package:client_ao/src/modules/home/states/collections.state.dart';
import 'package:client_ao/src/shared/models/collection.model.dart';
import 'package:client_ao/src/shared/utils/client_ao_extensions.dart';
import 'package:client_ao/src/shared/models/key_value_row.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UrlPreview extends HookConsumerWidget {
  const UrlPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeId = ref.watch(activeIdProvider);
    final collectionIndex = ref.watch(collectionsNotifierProvider.notifier).indexOfId();
    final collection = ref.watch(collectionsNotifierProvider).get(collectionIndex);
    final urlToPreview = useState<String?>('');

    useEffect(
      () {
        final urlParamsList = collection?.requests?.get(activeId?.requestId)?.urlParams;
        final url = Uri.tryParse(collection?.requests?.get(activeId?.requestId)?.url ?? '');

        if (url != null) {
          final queryParams = <String, String>{};

          final currentQueryParams = url.queryParameters;
          if (currentQueryParams.isNotEmpty) {
            queryParams.addAll(currentQueryParams);
          }

          for (final e in urlParamsList ?? <KeyValueRow>[]) {
            if (e.key != null) {
              queryParams[e.key.toString()] = e.value ?? '';
            }
          }

          urlToPreview.value = url.replace(queryParameters: queryParams).toString();
        }

        return;
      },
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(child: Text('${urlToPreview.value}')),
        IconButton(
          onPressed: () => copyToClipboard(collection, activeId, context),
          icon: const Icon(Icons.copy_outlined),
        ),
      ]),
    );
  }

  void copyToClipboard(CollectionModel? collection, ActiveId? activeId, BuildContext context) {
    Clipboard.setData(ClipboardData(text: collection?.requests?.get(activeId?.requestId ?? 0)?.url)).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('URL Copied to clipboard')),
        );
      },
    );
  }
}
