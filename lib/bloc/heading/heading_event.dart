part of 'heading_bloc.dart'; // Will be created next

abstract class HeadingEvent extends Equatable {
  const HeadingEvent();

  @override
  List<Object?> get props => [];
}

class LoadHeadings extends HeadingEvent {
  final bool forceRefresh;

  const LoadHeadings({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}
