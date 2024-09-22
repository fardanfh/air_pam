part of 'tagihan_bloc.dart';

abstract class TagihanState extends Equatable {
  const TagihanState();

  @override
  List<Object> get props => [];
}

 class TagihanInitial extends TagihanState {}

 class TagihanLoading extends TagihanState {}

 class TagihanFailed extends TagihanState {
  final String e;
  const TagihanFailed(this.e);
  @override
  List<Object> get props => [e];
}

 class TagihanSuccess extends TagihanState {
  final List<TagihanModel> tagihanCard;
  const TagihanSuccess(this.tagihanCard);

  @override
  List<Object> get props => [tagihanCard];
}
