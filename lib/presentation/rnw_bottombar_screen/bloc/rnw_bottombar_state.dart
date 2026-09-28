part of 'rnw_bottombar_bloc.dart';

class RnwBottombarState extends Equatable {
  const RnwBottombarState({required this.bottomBarState});

  final BottomBarState bottomBarState;

  @override
  List<Object?> get props => [bottomBarState];
  RnwBottombarState copyWith({BottomBarState? bottomBarState}) {
    return RnwBottombarState(bottomBarState: bottomBarState ?? this.bottomBarState);
  }
}
