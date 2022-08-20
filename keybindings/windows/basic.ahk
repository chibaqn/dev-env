; 公式ドキュメント: https://www.autohotkey.com/docs/KeyList.htm

;===========================================================================
; HHKB を快適に使うための設定

;-----------------------------------------------------------
; コマンドキー（Winキー）で日本語入力を切り替えるための設定
;   ・コマンドキーに 変換/無変換 キーを割り当てる。
;   ・Google 日本語入力で 変換/無変換 キーに IME ON/OFF を割り当てる。
;-----------------------------------------------------------
LWin::vk1D ;無変換
RWin::vk1C ;変換

;-----------------------------------------------------------
; ";" と ":" の入れ替え
;-----------------------------------------------------------
*vkBA::
    If (GetKeyState("Shift")){
        Send `;
    }
    else {
        Send :
    }
    return

;===========================================================================
;  Vim のための設定

;-----------------------------------------------------------
; Vim ライクなカーソル操作
;-----------------------------------------------------------
Ctrl & h::Send,{Left}
Ctrl & j::Send,{Down}
Ctrl & k::Send,{Up}
Ctrl & l::Send,{Right}

;-----------------------------------------------------------
; ESC キーが押されたら、英数キーも送信する。
;-----------------------------------------------------------
*Esc::
    getIMEMode := IME_GET()
    if (getIMEMode = 1) {
        Send {Esc}
        IME_SET(0)
    } else {
        Send {Esc}
    }
    return

;===========================================================================
; 下記のサイトからダウンロードした IME 制御用 関数群から必要なものをコピーした。
;
; https://w.atwiki.jp/eamat/pages/17.html
;
;-----------------------------------------------------------
; IMEの状態の取得
;   WinTitle="A"    対象Window
;   戻り値          1:ON / 0:OFF
;-----------------------------------------------------------
IME_GET(WinTitle="A")  {
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
	    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
	    NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x0005  ;wParam  : IMC_GETOPENSTATUS
          ,  Int, 0)      ;lParam  : 0
}
;-----------------------------------------------------------
; IMEの状態をセット
;   SetSts          1:ON / 0:OFF
;   WinTitle="A"    対象Window
;   戻り値          0:成功 / 0以外:失敗
;-----------------------------------------------------------
IME_SET(SetSts, WinTitle="A")    {
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
	    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
	    NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}

    return DllCall("SendMessage"
          , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
          , UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
}
