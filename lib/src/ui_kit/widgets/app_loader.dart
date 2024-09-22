

import 'package:acces_make_mobile/src/ui_kit/ui_kit.dart';
import 'package:flutter/cupertino.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(
        color: AppColors.grey,
      ),
    );
  }
}
