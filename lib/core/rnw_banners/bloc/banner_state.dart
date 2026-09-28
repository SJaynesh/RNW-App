part of 'banner_bloc.dart';

class BannerState extends Equatable {
  const BannerState({this.bannersModel, this.isLoading = false});
  final BannersModel? bannersModel;
  final bool isLoading;

  @override
  List<Object?> get props => [bannersModel, isLoading];
  BannerState copyWith({BannersModel? bannersModel, bool? isLoading}) {
    return BannerState(
        bannersModel: bannersModel ?? this.bannersModel,
        isLoading: isLoading ?? this.isLoading);
  }
}
