import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:air_pam/models/tagihan_model.dart';
import 'package:air_pam/services/tagihan_service.dart';

part 'tagihan_event.dart';
part 'tagihan_state.dart';

class TagihanBloc extends Bloc<TagihanEvent, TagihanState> {
  TagihanBloc() : super(TagihanInitial()) {
    on<TagihanEvent>((event, emit) async {
      if (event is TagihanGet) {
        try {
          emit(TagihanLoading());

          final tagihanCard = await TagihanService().getTagihan();
          print(tagihanCard);

          emit(TagihanSuccess(tagihanCard));
        } catch (e) {
          emit(TagihanFailed(e.toString()));
        }
      }
    });
  }
}
