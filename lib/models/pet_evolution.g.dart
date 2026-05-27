// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_evolution.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPetEvolutionCollection on Isar {
  IsarCollection<PetEvolution> get petEvolutions => this.collection();
}

const PetEvolutionSchema = CollectionSchema(
  name: r'PetEvolution',
  id: -1280186814871561430,
  properties: {
    r'allowShowTeamBattleStarArray': PropertySchema(
      id: 0,
      name: r'allowShowTeamBattleStarArray',
      type: IsarType.longList,
    ),
    r'evolutionChain': PropertySchema(
      id: 1,
      name: r'evolutionChain',
      type: IsarType.objectList,
      target: r'EvolutionNode',
    ),
    r'evolutionGroup': PropertySchema(
      id: 2,
      name: r'evolutionGroup',
      type: IsarType.long,
    ),
    r'handbookEvolutionGroup': PropertySchema(
      id: 3,
      name: r'handbookEvolutionGroup',
      type: IsarType.long,
    ),
    r'id': PropertySchema(id: 4, name: r'id', type: IsarType.long),
    r'lastSyncedVersion': PropertySchema(
      id: 5,
      name: r'lastSyncedVersion',
      type: IsarType.long,
    ),
    r'name': PropertySchema(id: 6, name: r'name', type: IsarType.string),
    r'pvpMuteGroup': PropertySchema(
      id: 7,
      name: r'pvpMuteGroup',
      type: IsarType.long,
    ),
    r'statisticsEvolutionGroup': PropertySchema(
      id: 8,
      name: r'statisticsEvolutionGroup',
      type: IsarType.long,
    ),
    r'talentRandomId': PropertySchema(
      id: 9,
      name: r'talentRandomId',
      type: IsarType.long,
    ),
  },
  estimateSize: _petEvolutionEstimateSize,
  serialize: _petEvolutionSerialize,
  deserialize: _petEvolutionDeserialize,
  deserializeProp: _petEvolutionDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {r'EvolutionNode': EvolutionNodeSchema},
  getId: _petEvolutionGetId,
  getLinks: _petEvolutionGetLinks,
  attach: _petEvolutionAttach,
  version: '3.1.0+1',
);

int _petEvolutionEstimateSize(
  PetEvolution object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.allowShowTeamBattleStarArray;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final list = object.evolutionChain;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[EvolutionNode]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += EvolutionNodeSchema.estimateSize(
            value,
            offsets,
            allOffsets,
          );
        }
      }
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _petEvolutionSerialize(
  PetEvolution object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.allowShowTeamBattleStarArray);
  writer.writeObjectList<EvolutionNode>(
    offsets[1],
    allOffsets,
    EvolutionNodeSchema.serialize,
    object.evolutionChain,
  );
  writer.writeLong(offsets[2], object.evolutionGroup);
  writer.writeLong(offsets[3], object.handbookEvolutionGroup);
  writer.writeLong(offsets[4], object.id);
  writer.writeLong(offsets[5], object.lastSyncedVersion);
  writer.writeString(offsets[6], object.name);
  writer.writeLong(offsets[7], object.pvpMuteGroup);
  writer.writeLong(offsets[8], object.statisticsEvolutionGroup);
  writer.writeLong(offsets[9], object.talentRandomId);
}

PetEvolution _petEvolutionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PetEvolution();
  object.allowShowTeamBattleStarArray = reader.readLongList(offsets[0]);
  object.evolutionChain = reader.readObjectList<EvolutionNode>(
    offsets[1],
    EvolutionNodeSchema.deserialize,
    allOffsets,
    EvolutionNode(),
  );
  object.evolutionGroup = reader.readLongOrNull(offsets[2]);
  object.handbookEvolutionGroup = reader.readLongOrNull(offsets[3]);
  object.id = reader.readLong(offsets[4]);
  object.isarId = id;
  object.lastSyncedVersion = reader.readLong(offsets[5]);
  object.name = reader.readStringOrNull(offsets[6]);
  object.pvpMuteGroup = reader.readLongOrNull(offsets[7]);
  object.statisticsEvolutionGroup = reader.readLongOrNull(offsets[8]);
  object.talentRandomId = reader.readLongOrNull(offsets[9]);
  return object;
}

P _petEvolutionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset)) as P;
    case 1:
      return (reader.readObjectList<EvolutionNode>(
            offset,
            EvolutionNodeSchema.deserialize,
            allOffsets,
            EvolutionNode(),
          ))
          as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _petEvolutionGetId(PetEvolution object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _petEvolutionGetLinks(PetEvolution object) {
  return [];
}

void _petEvolutionAttach(
  IsarCollection<dynamic> col,
  Id id,
  PetEvolution object,
) {
  object.isarId = id;
}

extension PetEvolutionByIndex on IsarCollection<PetEvolution> {
  Future<PetEvolution?> getById(int id) {
    return getByIndex(r'id', [id]);
  }

  PetEvolution? getByIdSync(int id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(int id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(int id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<PetEvolution?>> getAllById(List<int> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<PetEvolution?> getAllByIdSync(List<int> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<int> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<int> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(PetEvolution object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(PetEvolution object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<PetEvolution> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<PetEvolution> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension PetEvolutionQueryWhereSort
    on QueryBuilder<PetEvolution, PetEvolution, QWhere> {
  QueryBuilder<PetEvolution, PetEvolution, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IndexWhereClause.any(indexName: r'id'));
    });
  }
}

extension PetEvolutionQueryWhere
    on QueryBuilder<PetEvolution, PetEvolution, QWhereClause> {
  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> isarIdNotEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> isarIdGreaterThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> idEqualTo(
    int id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'id', value: [id]),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> idNotEqualTo(
    int id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [id],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'id',
                lower: [],
                upper: [id],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> idGreaterThan(
    int id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'id',
          lower: [id],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> idLessThan(
    int id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'id',
          lower: [],
          upper: [id],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'id',
          lower: [lowerId],
          includeLower: includeLower,
          upper: [upperId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension PetEvolutionQueryFilter
    on QueryBuilder<PetEvolution, PetEvolution, QFilterCondition> {
  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'allowShowTeamBattleStarArray'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(
          property: r'allowShowTeamBattleStarArray',
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'allowShowTeamBattleStarArray',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'allowShowTeamBattleStarArray',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'allowShowTeamBattleStarArray',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'allowShowTeamBattleStarArray',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowShowTeamBattleStarArray',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowShowTeamBattleStarArray',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowShowTeamBattleStarArray',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowShowTeamBattleStarArray',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowShowTeamBattleStarArray',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  allowShowTeamBattleStarArrayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'allowShowTeamBattleStarArray',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionChainIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'evolutionChain'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionChainIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'evolutionChain'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionChainLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'evolutionChain', length, true, length, true);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionChainIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'evolutionChain', 0, true, 0, true);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionChainIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'evolutionChain', 0, false, 999999, true);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionChainLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'evolutionChain', 0, true, length, include);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionChainLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'evolutionChain', length, include, 999999, true);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionChainLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'evolutionChain',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'evolutionGroup'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'evolutionGroup'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionGroupEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'evolutionGroup', value: value),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionGroupGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'evolutionGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionGroupLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'evolutionGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionGroupBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'evolutionGroup',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  handbookEvolutionGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'handbookEvolutionGroup'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  handbookEvolutionGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'handbookEvolutionGroup'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  handbookEvolutionGroupEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'handbookEvolutionGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  handbookEvolutionGroupGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'handbookEvolutionGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  handbookEvolutionGroupLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'handbookEvolutionGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  handbookEvolutionGroupBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'handbookEvolutionGroup',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> isarIdEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  lastSyncedVersionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'lastSyncedVersion', value: value),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  lastSyncedVersionGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'lastSyncedVersion',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  lastSyncedVersionLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'lastSyncedVersion',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  lastSyncedVersionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'lastSyncedVersion',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'name'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'name'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  nameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  pvpMuteGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'pvpMuteGroup'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  pvpMuteGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'pvpMuteGroup'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  pvpMuteGroupEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pvpMuteGroup', value: value),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  pvpMuteGroupGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pvpMuteGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  pvpMuteGroupLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pvpMuteGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  pvpMuteGroupBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pvpMuteGroup',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  statisticsEvolutionGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'statisticsEvolutionGroup'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  statisticsEvolutionGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'statisticsEvolutionGroup'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  statisticsEvolutionGroupEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'statisticsEvolutionGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  statisticsEvolutionGroupGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'statisticsEvolutionGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  statisticsEvolutionGroupLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'statisticsEvolutionGroup',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  statisticsEvolutionGroupBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'statisticsEvolutionGroup',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  talentRandomIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'talentRandomId'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  talentRandomIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'talentRandomId'),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  talentRandomIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'talentRandomId', value: value),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  talentRandomIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'talentRandomId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  talentRandomIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'talentRandomId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  talentRandomIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'talentRandomId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension PetEvolutionQueryObject
    on QueryBuilder<PetEvolution, PetEvolution, QFilterCondition> {
  QueryBuilder<PetEvolution, PetEvolution, QAfterFilterCondition>
  evolutionChainElement(FilterQuery<EvolutionNode> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'evolutionChain');
    });
  }
}

extension PetEvolutionQueryLinks
    on QueryBuilder<PetEvolution, PetEvolution, QFilterCondition> {}

extension PetEvolutionQuerySortBy
    on QueryBuilder<PetEvolution, PetEvolution, QSortBy> {
  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByEvolutionGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evolutionGroup', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByEvolutionGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evolutionGroup', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByHandbookEvolutionGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handbookEvolutionGroup', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByHandbookEvolutionGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handbookEvolutionGroup', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByLastSyncedVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedVersion', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByLastSyncedVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedVersion', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> sortByPvpMuteGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pvpMuteGroup', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByPvpMuteGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pvpMuteGroup', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByStatisticsEvolutionGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statisticsEvolutionGroup', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByStatisticsEvolutionGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statisticsEvolutionGroup', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByTalentRandomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'talentRandomId', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  sortByTalentRandomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'talentRandomId', Sort.desc);
    });
  }
}

extension PetEvolutionQuerySortThenBy
    on QueryBuilder<PetEvolution, PetEvolution, QSortThenBy> {
  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByEvolutionGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evolutionGroup', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByEvolutionGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'evolutionGroup', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByHandbookEvolutionGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handbookEvolutionGroup', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByHandbookEvolutionGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'handbookEvolutionGroup', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByLastSyncedVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedVersion', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByLastSyncedVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncedVersion', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy> thenByPvpMuteGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pvpMuteGroup', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByPvpMuteGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pvpMuteGroup', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByStatisticsEvolutionGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statisticsEvolutionGroup', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByStatisticsEvolutionGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statisticsEvolutionGroup', Sort.desc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByTalentRandomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'talentRandomId', Sort.asc);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QAfterSortBy>
  thenByTalentRandomIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'talentRandomId', Sort.desc);
    });
  }
}

extension PetEvolutionQueryWhereDistinct
    on QueryBuilder<PetEvolution, PetEvolution, QDistinct> {
  QueryBuilder<PetEvolution, PetEvolution, QDistinct>
  distinctByAllowShowTeamBattleStarArray() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allowShowTeamBattleStarArray');
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QDistinct>
  distinctByEvolutionGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'evolutionGroup');
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QDistinct>
  distinctByHandbookEvolutionGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'handbookEvolutionGroup');
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QDistinct> distinctById() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id');
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QDistinct>
  distinctByLastSyncedVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSyncedVersion');
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QDistinct> distinctByPvpMuteGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pvpMuteGroup');
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QDistinct>
  distinctByStatisticsEvolutionGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statisticsEvolutionGroup');
    });
  }

  QueryBuilder<PetEvolution, PetEvolution, QDistinct>
  distinctByTalentRandomId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'talentRandomId');
    });
  }
}

extension PetEvolutionQueryProperty
    on QueryBuilder<PetEvolution, PetEvolution, QQueryProperty> {
  QueryBuilder<PetEvolution, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<PetEvolution, List<int>?, QQueryOperations>
  allowShowTeamBattleStarArrayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allowShowTeamBattleStarArray');
    });
  }

  QueryBuilder<PetEvolution, List<EvolutionNode>?, QQueryOperations>
  evolutionChainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'evolutionChain');
    });
  }

  QueryBuilder<PetEvolution, int?, QQueryOperations> evolutionGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'evolutionGroup');
    });
  }

  QueryBuilder<PetEvolution, int?, QQueryOperations>
  handbookEvolutionGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'handbookEvolutionGroup');
    });
  }

  QueryBuilder<PetEvolution, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PetEvolution, int, QQueryOperations>
  lastSyncedVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSyncedVersion');
    });
  }

  QueryBuilder<PetEvolution, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<PetEvolution, int?, QQueryOperations> pvpMuteGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pvpMuteGroup');
    });
  }

  QueryBuilder<PetEvolution, int?, QQueryOperations>
  statisticsEvolutionGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statisticsEvolutionGroup');
    });
  }

  QueryBuilder<PetEvolution, int?, QQueryOperations> talentRandomIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'talentRandomId');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const EvolutionNodeSchema = Schema(
  name: r'EvolutionNode',
  id: -8853529492981206424,
  properties: {
    r'level': PropertySchema(id: 0, name: r'level', type: IsarType.long),
    r'petName': PropertySchema(id: 1, name: r'petName', type: IsarType.string),
    r'petbaseId': PropertySchema(
      id: 2,
      name: r'petbaseId',
      type: IsarType.long,
    ),
    r'stage': PropertySchema(id: 3, name: r'stage', type: IsarType.long),
    r'unitType': PropertySchema(
      id: 4,
      name: r'unitType',
      type: IsarType.longList,
    ),
  },
  estimateSize: _evolutionNodeEstimateSize,
  serialize: _evolutionNodeSerialize,
  deserialize: _evolutionNodeDeserialize,
  deserializeProp: _evolutionNodeDeserializeProp,
);

int _evolutionNodeEstimateSize(
  EvolutionNode object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.petName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.unitType;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _evolutionNodeSerialize(
  EvolutionNode object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.level);
  writer.writeString(offsets[1], object.petName);
  writer.writeLong(offsets[2], object.petbaseId);
  writer.writeLong(offsets[3], object.stage);
  writer.writeLongList(offsets[4], object.unitType);
}

EvolutionNode _evolutionNodeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EvolutionNode();
  object.level = reader.readLongOrNull(offsets[0]);
  object.petName = reader.readStringOrNull(offsets[1]);
  object.petbaseId = reader.readLongOrNull(offsets[2]);
  object.stage = reader.readLongOrNull(offsets[3]);
  object.unitType = reader.readLongList(offsets[4]);
  return object;
}

P _evolutionNodeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension EvolutionNodeQueryFilter
    on QueryBuilder<EvolutionNode, EvolutionNode, QFilterCondition> {
  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  levelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'level'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  levelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'level'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  levelEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'level', value: value),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  levelGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'level',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  levelLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'level',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  levelBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'level',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'petName'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'petName'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'petName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'petName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'petName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'petName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'petName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'petName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'petName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'petName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'petName', value: ''),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'petName', value: ''),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petbaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'petbaseId'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petbaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'petbaseId'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petbaseIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'petbaseId', value: value),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petbaseIdGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'petbaseId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petbaseIdLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'petbaseId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  petbaseIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'petbaseId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  stageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'stage'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  stageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'stage'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  stageEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'stage', value: value),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  stageGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'stage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  stageLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'stage',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  stageBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'stage',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'unitType'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'unitType'),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'unitType', value: value),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeElementGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'unitType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeElementLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'unitType',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'unitType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'unitType', length, true, length, true);
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'unitType', 0, true, 0, true);
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'unitType', 0, false, 999999, true);
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'unitType', 0, true, length, include);
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'unitType', length, include, 999999, true);
    });
  }

  QueryBuilder<EvolutionNode, EvolutionNode, QAfterFilterCondition>
  unitTypeLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'unitType',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension EvolutionNodeQueryObject
    on QueryBuilder<EvolutionNode, EvolutionNode, QFilterCondition> {}
