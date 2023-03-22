import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            Text(
              message ?? "Loading...",
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(),
          ],
        ),
      );
}
