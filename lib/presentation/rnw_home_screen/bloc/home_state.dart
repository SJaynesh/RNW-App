part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({this.studentListModel, this.isLoading = false});

  final StudentListModel? studentListModel;
  final bool isLoading;

  @override
  List<Object?> get props => [studentListModel, isLoading];

  HomeState copyWith({
    StudentListModel? studentListModel,
    bool? isLoading,
  }) {
    return HomeState(
        studentListModel: studentListModel ?? this.studentListModel,
        isLoading: isLoading ?? this.isLoading);
  }
}
