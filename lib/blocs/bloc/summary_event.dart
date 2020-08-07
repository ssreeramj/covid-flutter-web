part of 'summary_bloc.dart';

abstract class SummaryEvent extends Equatable {
  const SummaryEvent();
}

class FetchDetails extends SummaryEvent {
  const FetchDetails();
  @override
  List<Object> get props => [];
}
