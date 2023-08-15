import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../infrastructure/profile_repo.dart';
import 'profile_state.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(ref, ProfileRepo()),
  name: 'otherProblemProvider',
);

class ProfileNotifier extends StateNotifier<ProfileState> {
  final Ref ref;
  final ProfileRepo repo;
  ProfileNotifier(this.ref, this.repo) : super(ProfileState.init());
}
