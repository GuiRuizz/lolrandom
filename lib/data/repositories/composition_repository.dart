import '../../domain/entities/champion.dart';

abstract class CompositionRepository {
  Future<List<Champion>> getChampions();
}
