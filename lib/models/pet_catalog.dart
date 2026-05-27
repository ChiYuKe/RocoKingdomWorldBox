import 'pet_model.dart';

class PetSpeciesGroup {
  final int pictorialBookId;
  final List<PetModel> variants;

  const PetSpeciesGroup({
    required this.pictorialBookId,
    required this.variants,
  });

  PetModel get displayPet => variants.first;

  bool containsPetId(int id) {
    return variants.any((pet) => pet.id == id);
  }
}

class PetCatalog {
  final List<PetModel> pets;
  final List<PetSpeciesGroup> groups;

  const PetCatalog({required this.pets, required this.groups});

  factory PetCatalog.fromPets(List<PetModel> source) {
    final pets = List<PetModel>.from(source)
      ..sort((a, b) {
        final bookCompare = a.pictorialBookId.compareTo(b.pictorialBookId);
        if (bookCompare != 0) return bookCompare;
        return a.id.compareTo(b.id);
      });

    final grouped = <int, List<PetModel>>{};
    for (final pet in pets) {
      grouped.putIfAbsent(pet.pictorialBookId, () => <PetModel>[]).add(pet);
    }

    return PetCatalog(
      pets: pets,
      groups: grouped.entries
          .map(
            (entry) => PetSpeciesGroup(
              pictorialBookId: entry.key,
              variants: List.unmodifiable(entry.value),
            ),
          )
          .toList(growable: false),
    );
  }

  bool get isEmpty => pets.isEmpty;

  int get length => pets.length;

  int normalizeIndex(int index) {
    if (pets.isEmpty) return 0;
    return index.clamp(0, pets.length - 1).toInt();
  }

  PetModel? petAt(int index) {
    if (pets.isEmpty) return null;
    return pets[normalizeIndex(index)];
  }

  int indexOf(PetModel pet) {
    return pets.indexWhere((item) => item.id == pet.id);
  }
}
