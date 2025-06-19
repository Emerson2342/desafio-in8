import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/page.dart';

void openFilterDialog(BuildContext context, FiltersModel filtersList,
    void Function(FiltroModel) onApply) {
  showDialog(
    context: context,
    builder: (context) {
      String? categoria;
      String? material;
      String? min;
      String? max;
      String? orderBy;

      return AlertDialog(
        title: const Text('Filtrar produtos'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Categoria'),
                value: categoria,
                items: filtersList.categories
                    .map(
                        (cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => categoria = value,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Material'),
                value: material,
                items: filtersList.materials
                    .map(
                        (mat) => DropdownMenuItem(value: mat, child: Text(mat)))
                    .toList(),
                onChanged: (value) => material = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Preço mínimo'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => min = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Preço máximo'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => max = value,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Ordenar por'),
                items: const [
                  DropdownMenuItem(value: 'price', child: Text('Preço')),
                  DropdownMenuItem(value: 'name', child: Text('Nome')),
                ],
                onChanged: (value) => orderBy = value,
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onApply(FiltroModel(
                categoria: categoria,
                material: material,
                min: min,
                max: max,
                orderBy: orderBy,
              ));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary),
            child: Text('Aplicar', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}
