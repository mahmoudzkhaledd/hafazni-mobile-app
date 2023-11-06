import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafazni/GeneralWidgets/CustomButton.dart';
import 'package:hafazni/GeneralWidgets/CustomUserImage.dart';

import '../../Blocs/cubit/profile_settings_cubit.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileSettingsCubit>();
    return BlocBuilder<ProfileSettingsCubit, ProfileSettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            Stack(
              children: [
                CustomUserImage(
                  url: cubit.user.profilePic,
                  radius: 70,
                  file: state is ChangeImageState ? state.image : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: Colors.black,
                    child: cubit.user.profilePic.isEmpty
                        ? IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 20,
                            onPressed: cubit.choosePic,
                            icon: const Icon(Icons.edit),
                          )
                        : IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 20,
                            onPressed: cubit.removePicOnline,
                            icon: const Icon(Icons.clear),
                          ),
                  ),
                ),
                if (state is ChangeImageState && state.image != null)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        onPressed: cubit.removePic,
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (state is ChangeImageState && state.image != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: SizedBox(
                  width: 170,
                  child: CustomButton(
                    text: 'رفع الصورة',
                    verticalPadding: 6,
                    icon: const Icon(
                      Icons.upload,
                      color: Colors.white,
                    ),
                    onTap: cubit.uploadPhoto,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
