import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_web/models/summary.dart';
import 'package:covid_web/repositories/summary_repository.dart';
import 'package:equatable/equatable.dart';

part 'summary_event.dart';
part 'summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final SummaryRepository repository;

  SummaryBloc(this.repository) : super(SummaryInitial());

  @override
  // ignore: override_on_non_overriding_member
  SummaryState get initialState => SummaryInitial();

  @override
  Stream<SummaryState> mapEventToState(
    SummaryEvent event,
  ) async* {
    yield SummaryLoading();
    try {
      final Summary summary = await repository.fetchAllDetails();
      yield SummaryLoaded(summary);
    } catch (_) {
      yield SummaryError();
    }
  }
}
