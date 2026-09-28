part of 'fees_detail_bloc.dart';

class FeesDetailState extends Equatable {
  const FeesDetailState({this.feeDetailsModel, this.isLoading = false});
  final FeeDetailsModel? feeDetailsModel;
  final bool isLoading;

  @override
  List<Object?> get props => [feeDetailsModel, isLoading];
  FeesDetailState copyWith(
      {FeeDetailsModel? feeDetailsModel, bool? isLoading}) {
    return FeesDetailState(
        feeDetailsModel: feeDetailsModel ?? this.feeDetailsModel,
        isLoading: isLoading ?? this.isLoading);
  }
}

class FeesDetailInitial extends FeesDetailState {}
