# CSGO settings

```text
// unbinds
unbind x

// pickup
cl_autowepswitch 0

// fps
fps_max 180
cl_showfps 1

// radar
cl_radar_always_centered 1
cl_radar_scale 0.3
cl_hud_radar_scale 1.15
cl_radar_icon_scale_min 0.6
bind "KP_plus" "incrementvar cl_radar_scale 0.25 1.0 0.05"
bind "KP_minus" "incrementvar cl_radar_scale 0.25 1.0 -0.05"

// view model
viewmodel_fov 68
viewmodel_offset_x 2.3
viewmodel_offset_y 2
viewmodel_offset_z -2
viewmodel_presetpos 0
cl_viewmodel_shift_left_amt 1.5
cl_viewmodel_shift_right_amt 0.75
viewmodel_recoil 0
cl_righthand 1

// cross hair
cl_crosshair_drawoutline 0
cl_crosshair_sniper_width 1
cl_crosshairalpha 255
cl_crosshaircolor 5
cl_crosshaircolor_b 192
cl_crosshaircolor_g 255
cl_crosshaircolor_r 0
cl_crosshairdot 1
cl_crosshairgap -1
cl_crosshairsize 3
cl_crosshairstyle 5
cl_crosshairthickness 0.5


// binds
alias "+jumpthrow" "+jump;-attack"
alias "-jumpthrow" "-jump"
bind alt "+jumpthrow"

// cl_bob
cl_bob_lower_amt 9
cl_bobamt_lat 0.33
cl_bobamt_vert 0.14
cl_bobcycle 0.98
```

