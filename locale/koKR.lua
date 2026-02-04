local ADDON_NAME, private = ...

local L = private:NewLocale("koKR")
if not L then return end

L.SlashBG = "배경"
L.SlashBGOn = "LagBar: 배경이 이제 [|cFF99CC33표시됨|r]"
L.SlashBGOff = "LagBar: 배경이 이제 [|cFF99CC33숨김|r]"
L.SlashBGInfo = "창 배경 표시."

L.SlashTT = "툴팁"
L.SlashTTOn = "LagBar: 마우스오버 툴팁이 이제 [|cFF99CC33표시됨|r]"
L.SlashTTOff = "LagBar: 마우스오버 툴팁이 이제 [|cFF99CC33숨김|r]"
L.SlashTTInfo = "데이터 위에 마우스를 올리면 툴팁을 표시합니다."

L.SlashReset = "리셋"
L.SlashResetInfo = "프레임 위치를 초기화합니다."
L.SlashResetAlert = "LagBar: 프레임 위치가 초기화되었습니다!"

L.SlashScale = "크기"
L.SlashScaleSet = "LagBar: 크기가 [|cFF20ff20%s|r]로 설정되었습니다"
L.SlashScaleSetInvalid = "크기 값이 잘못되었습니다! 숫자는 [0.5 - 5] 사이여야 합니다.  (0.5, 1, 3, 4.6, 등)"
L.SlashScaleInfo = "LagBar 프레임 크기를 설정합니다 (0.5 - 5)."
L.SlashScaleText = "LagBar 프레임 크기"

L.SlashFPS = "fps"
L.SlashFPSOn = "LagBar: FPS가 이제 [|cFF99CC33켜짐|r]"
L.SlashFPSOff = "LagBar: FPS가 이제 [|cFF99CC33꺼짐|r]"
L.SlashFPSInfo = "FPS 표시를 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashFPSChkBtn = "FPS 표시를 보여줍니다."

L.SlashHomePing = "홈핑"
L.SlashHomePingOn = "LagBar: 홈핑이 이제 [|cFF99CC33켜짐|r]"
L.SlashHomePingOff = "LagBar: 홈핑이 이제 [|cFF99CC33꺼짐|r]"
L.SlashHomePingInfo = "홈 핑 표시를 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashHomePingChkBtn = "홈 핑 표시를 보여줍니다."

L.SlashWorldPing = "월드핑"
L.SlashWorldPingOn = "LagBar: 월드핑이 이제 [|cFF99CC33켜짐|r]"
L.SlashWorldPingOff = "LagBar: 월드핑이 이제 [|cFF99CC33꺼짐|r]"
L.SlashWorldPingInfo = "월드 핑 표시를 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashWorldPingChkBtn = "월드 핑 표시를 보여줍니다."

L.SlashImpDisplay = "개선"
L.SlashImpDisplayOn = "LagBar: 향상된 핑 표시가 이제 [|cFF99CC33켜짐|r]"
L.SlashImpDisplayOff = "LagBar: 향상된 핑 표시가 이제 [|cFF99CC33꺼짐|r]"
L.SlashImpDisplayInfo = "향상된 핑 표시를 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashImpDisplayChkBtn = "향상된 핑 표시를 보여줍니다."

L.SlashMetricLabels = "메트릭"
L.SlashMetricLabelsOn = "LagBar: 메트릭 라벨이 이제 [|cFF99CC33켜짐|r]"
L.SlashMetricLabelsOff = "LagBar: 메트릭 라벨이 이제 [|cFF99CC33꺼짐|r]"
L.SlashMetricLabelsInfo = "메트릭 라벨 표시를 전환합니다 (|cFF99CC33켜짐/꺼짐|r)."
L.SlashMetricLabelsChkBtn = "메트릭 라벨을 표시합니다."

L.SlashClampToScreenChkBtn = "LagBar 프레임을 화면 안에 고정합니다. |cFF99CC33(화면 밖으로 드래그되는 것을 방지)|r"

L.AddonLoginMsg = "로그인 시 애드온 로드 알림을 표시합니다."

L.TooltipDragInfo = "[Shift 키를 누른 채 드래그하여 창을 이동합니다.]"
L.FPS = "fps"
L.Milliseconds = "ms"
L.Home = "홈"
L.World = "월드"
