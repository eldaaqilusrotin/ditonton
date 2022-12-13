import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';

class FakeSearchTvState extends Fake implements SearchTvState {}

class FakeSearchTvEvent extends Fake implements SearchTvEvent {}

class MockSearchTvBloc extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}
