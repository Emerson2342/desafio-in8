import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback firstPage;
  final VoidCallback lastPage;

  const PaginationWidget(
      {super.key,
      required this.currentPage,
      required this.totalPages,
      required this.onPrevious,
      required this.onNext,
      required this.firstPage,
      required this.lastPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: currentPage != 1 ? firstPage : null,
            icon: const Icon(Icons.first_page)),
        IconButton(
            onPressed: currentPage > 1 ? onPrevious : null,
            icon: const Icon(Icons.chevron_left)),
        Text("Página $currentPage de $totalPages",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        IconButton(
            onPressed: currentPage < totalPages ? onNext : null,
            icon: const Icon(Icons.chevron_right)),
        IconButton(
            onPressed: currentPage != totalPages ? lastPage : null,
            icon: const Icon(Icons.last_page)),
      ],
    );
  }
}
