import 'package:commute/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../flutter_flow/flutter_flow_theme.dart';
import '../../../../flutter_flow/flutter_flow_widgets.dart';

class CommuteCheckPage extends GetView<HomeController> {
  const CommuteCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<HomeController>(builder: (_) {
        return Container(
          child: (controller.localCommute == null)
              ? Container()
              : (controller.localCommute!.comeAt == null)
              ? NotCommuteYetSheet(
            func: controller.checkStart,
          )
              : (controller.localCommute!.endAt == null)
              ? WorkingNowSheet(
            func: controller.checkFinish,
          )
              : AlreadyGoHomeSheet(),
        );
      }),
    );
  }
}

class WorkingNowSheet extends StatelessWidget {
  const WorkingNowSheet({Key? key, required this.func}) : super(key: key);

  final Function func;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommutePageButton(
          func: func,
          text: '퇴근',
        ),
      ],
    );
  }
}

class AlreadyGoHomeSheet extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<HomeController>(builder: (_) {
          return Center(
            child: IntrinsicHeight(
              child: Container(
                color: CupertinoTheme.of(context).barBackgroundColor,
                child: CupertinoFormRow(
                  prefix: Row(
                    children: <Widget>[
                      Icon(
                        // Wifi icon is updated based on switch value.
                        controller.localCommute!.workAtLunch!
                            ? CupertinoIcons.wifi
                            : CupertinoIcons.wifi_slash,
                        color: controller.localCommute!.workAtLunch!
                            ? CupertinoColors.systemBlue
                            : CupertinoColors.systemRed,
                      ),
                      const SizedBox(width: 10),
                      const Text('점심시간 근무')
                    ],
                  ),
                  child: CupertinoSwitch(
                    // This bool value toggles the switch.
                    value: controller.localCommute!.workAtLunch!,
                    thumbColor: CupertinoColors.systemBlue,
                    trackColor: CupertinoColors.systemRed.withOpacity(0.14),
                    activeColor: CupertinoColors.systemRed.withOpacity(0.64),
                    onChanged: (bool? value) {
                      // This is called when the user toggles the switch.
                      controller.changeLunchTimeWork(value!);
                    },
                  ),
                ),
              ),
            ),
          );
        }),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 16),
          child: TextFormField(
            obscureText: false,
            controller: controller.commentController,
            decoration: InputDecoration(
              labelText: 'Comment',
              labelStyle: FlutterFlowTheme.of(context).bodyText2,
              hintStyle: FlutterFlowTheme.of(context).bodyText2,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0x00000000),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
            ),
            style: FlutterFlowTheme.of(context).bodyText1,
            maxLines: null,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommutePageButton(
              func: controller.checkFinishAgain,
              text: '다시퇴근',
            ),
          ],
        ),
      ],
    );
  }
}

class NotCommuteYetSheet extends StatelessWidget {
  const NotCommuteYetSheet({Key? key, required this.func}) : super(key: key);

  final Function func;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommutePageButton(
          func: func,
          text: '출근',
        ),
      ],
    );
  }
}

class CommutePageButton extends StatelessWidget {
  const CommutePageButton({Key? key, required this.func, required this.text})
      : super(key: key);

  final Function func;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () {
        func();
      },
      text: text,
      options: FFButtonOptions(
        width: 150,
        height: 50,
        color: FlutterFlowTheme.of(context).primaryColor,
        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        elevation: 3,
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
    );
  }
}