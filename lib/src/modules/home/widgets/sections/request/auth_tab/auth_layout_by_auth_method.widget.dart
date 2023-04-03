import 'package:client_ao/src/core/constants/enums.dart';
import 'package:client_ao/src/modules/home/widgets/sections/request/auth_tab/auth_with_api_key.widget.dart';
import 'package:client_ao/src/modules/home/widgets/sections/request/auth_tab/authentication_options.widget.dart';
import 'package:client_ao/src/modules/home/widgets/sections/request/auth_tab/auth_with_bearer_token.widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthLayoutBasedOnMethod extends ConsumerWidget {
  const AuthLayoutBasedOnMethod({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(selectedAuthOptionProvider);

    switch (auth.method) {
      case AuthMethod.apiKeyAuth:
        return const AuthWithApiKey();
      case AuthMethod.bearerToken:
        return const AuthWithBearerToken();

      case AuthMethod.basic:
        return Container(color: Colors.red);
      case AuthMethod.noAuthentication:
        return Container(color: Colors.green);
    }
  }
}
