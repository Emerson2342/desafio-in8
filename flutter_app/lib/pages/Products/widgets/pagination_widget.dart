import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const PaginationWidget(
      {super.key,
      required this.currentPage,
      required this.totalPages,
      required this.onPrevious,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: currentPage > 1 ? onPrevious : null,
            icon: const Icon(Icons.arrow_back)),
        Text("Página $currentPage de $totalPages",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        IconButton(
            onPressed: currentPage < totalPages ? onNext : null,
            icon: const Icon(Icons.arrow_forward)),
      ],
    );
  }
}
