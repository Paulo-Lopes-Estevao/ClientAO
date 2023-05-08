import 'package:client_ao/src/shared/models/auth/auth_api_key.model.dart';
import 'package:client_ao/src/shared/models/key_value_row.model.dart';
import 'package:client_ao/src/shared/widgets/text_fields/textField_with_environment_suggestion.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authWithApiKeyProvider = StateProvider<AuthApiKeyModel>((ref) {
  return const AuthApiKeyModel(keyValue: KeyValueRow());
});

class AuthWithApiKey extends HookConsumerWidget {
  const AuthWithApiKey({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiKeyState = ref.watch(authWithApiKeyProvider);
    final apiKeyController = useTextEditingController(text: apiKeyState.keyValue?.key);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'ENABLED',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              Checkbox(
                value: apiKeyState.enabled,
                onChanged: (value) {
                  ref.read(authWithApiKeyProvider.notifier).state = apiKeyState.copyWith(
                    enabled: !apiKeyState.enabled,
                  );
                },
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('KEY'),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: apiKeyController,
                  onChanged: (value) {
                    ref.read(authWithApiKeyProvider.notifier).state = apiKeyState.copyWith(
                      keyValue: apiKeyState.keyValue?.copyWith(key: value),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('VALUE'),
              const SizedBox(width: 16),
              Expanded(
                child: TextFieldWithEnvironmentSuggestion(
                  onChanged: (value) {
                    ref.read(authWithApiKeyProvider.notifier).state = apiKeyState.copyWith(
                      keyValue: apiKeyState.keyValue?.copyWith(value: value),
                    );
                  },
                  parentContext: context,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
