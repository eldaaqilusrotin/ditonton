import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';


class FakeSearchMoviesState extends Fake implements SearchMoviesState {}

class FakeSearchMoviesEvent extends Fake implements SearchMoviesEvent {}

class MockSearchMoviesBloc
    extends MockBloc<SearchMoviesEvent, SearchMoviesState>
    implements SearchMoviesBloc {}
