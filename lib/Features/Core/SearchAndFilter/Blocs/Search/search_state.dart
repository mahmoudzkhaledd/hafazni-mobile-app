part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

class LodingMemorizersState extends SearchState {}

class ChangePageIndexSearchMemorizerState extends SearchState {
  final int index;

  ChangePageIndexSearchMemorizerState(this.index);
}

class LodedMemorizersState extends SearchState {
  
  LodedMemorizersState();
}
class FailLodingMemorizersState extends SearchState {}
class ChangeFiltersState extends SearchState {}
