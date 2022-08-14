part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}
class Searching extends SearchState {}
class SearchResults extends SearchState {}
class NoResultFound extends SearchState {}
