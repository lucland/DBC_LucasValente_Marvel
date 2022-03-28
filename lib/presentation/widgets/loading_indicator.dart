import 'package:dbc_lucas_valente/styles/custom_color.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: CustomColor.red,
        strokeWidth: 3,
      ),
    );
  }
}
