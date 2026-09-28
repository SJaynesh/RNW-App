part of 'fees_detail_bloc.dart';

class FeesDetailEvent extends Equatable {
  const FeesDetailEvent();

  @override
  List<Object> get props => [];
}

class FeesdetailsitialEvent extends FeesDetailEvent {
  @override
  List<Object> get props => [];
}

class FeesdetailsApi extends FeesDetailEvent {
  final String admissionId;

  const FeesdetailsApi({
    required this.admissionId,
  });

  @override
  List<Object> get props => [admissionId];
}
