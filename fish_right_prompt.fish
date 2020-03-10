# You can override some default right prompt options in your config.fish:
#     set -g theme_date_format "+%a %H:%M"

function __freddyfishy_cmd_duration -S -d 'Show command duration'
  [ "$theme_display_cmd_duration" = "no" ]; and return
  [ -z "$CMD_DURATION" -o "$CMD_DURATION" -lt 100 ]; and return

  if [ "$CMD_DURATION" -lt 5000 ]
    echo -ns $CMD_DURATION 'ms'
  else if [ "$CMD_DURATION" -lt 60000 ]
    __freddyfishy_pretty_ms $CMD_DURATION s
  else if [ "$CMD_DURATION" -lt 3600000 ]
    set_color $fish_color_error
    __freddyfishy_pretty_ms $CMD_DURATION m
  else
    set_color $fish_color_error
    __freddyfishy_pretty_ms $CMD_DURATION h
  end

  set_color $fish_color_normal
  set_color $fish_color_autosuggestion

  [ "$theme_display_date" = "no" ]
    or echo -ns ' ' $__freddyfishy_left_arrow_glyph
end

function __freddyfishy_pretty_ms -S -a ms interval -d 'Millisecond formatting for humans'
  set -l interval_ms
  set -l scale 1

  switch $interval
    case s
      set interval_ms 1000
    case m
      set interval_ms 60000
    case h
      set interval_ms 3600000
      set scale 2
  end

  switch $FISH_VERSION
    # Fish 2.3 and lower doesn't know about the -s argument to math.
    case 2.0.\* 2.1.\* 2.2.\* 2.3.\*
      math "scale=$scale;$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
    case \*
      math -s$scale "$ms/$interval_ms" | string replace -r '\\.?0*$' $interval
  end
end

function __freddyfishy_timestamp -S -d 'Show the current timestamp'
  [ "$theme_display_date" = "no" ]; and return
  set -q theme_date_format
    or set -l theme_date_format "+%c"

  echo -n ' '
  date $theme_date_format
end

function __freddyfishy_virtual_host --description "Output the $VIRTUAL_HOST if set."
    if test -n "$VIRTUAL_HOST"
        echo " http://$VIRTUAL_HOST "
    end
end

function __freddyfishy_battery
    # Check if acpi exists
    if not set -q __fish_nim_prompt_has_acpi
        if type -q acpi > /dev/null
            set -g __fish_nim_prompt_has_acpi 1
        else
            set -g __fish_nim_prompt_has_acpi '' # empty string
        end
    end

    if test "$__fish_nim_prompt_has_acpi"
      # Is the battery full?
      acpi -b 2> /dev/null | grep Full &>-
        set __freddyfishy_battery_is_full $status
      # Does the user always want to see the battery status even when full?
      if not set -q always_display_battery_status
        set always_display_battery_status = no
      end
      if test "$__freddyfishy_battery_is_full" -eq 1 -o \( "$__freddyfishy_battery_is_full" -eq 0 -a "$always_display_battery_status" = "yes" \)
        # Are powerline fonts installed? If so use battery icons.
        if test "$theme_powerline_fonts" = "no"
            set __freddyfishy_battery "Bat " (acpi -b|cut -d' ' -f 4|cut -d',' -f 1)
        else 
            set __freddyfishy_battery_percentage (acpi -b|cut -d' ' -f 4|cut -d',' -f 1|cut -d'%' -f 1)
            if test $__freddyfishy_battery_percentage -lt 25 
                set __freddyfishy_battery " $__freddyfishy_battery_percentage%"
            else if test $__freddyfishy_battery_percentage -ge 25 -a $__freddyfishy_battery_percentage -lt 50
                set __freddyfishy_battery ""
            else if test $__freddyfishy_battery_percentage -ge 50 -a $__freddyfishy_battery_percentage -lt 75
                set __freddyfishy_battery ""
            else if test $__freddyfishy_battery_percentage -ge 75 -a $__freddyfishy_battery_percentage -lt 95
                set __freddyfishy_battery ""
            else if test $__freddyfishy_battery_percentage -ge 95 -a $__freddyfishy_battery_percentage -le 100
              # Is the battery charging? If so then show the percentage of charge.
              acpi -b 2> /dev/null | grep Charging &>-
              set __freddyfishy_battery_is_charging $status
              if test "$__freddyfishy_battery_is_charging" -eq 0
                set __freddyfishy_battery " $__freddyfishy_battery_percentage%"
              else
                set __freddyfishy_battery ""
              end
            end
        end
        # Is the AC power adapter off-line?
        acpi -a 2>&- | grep off &>-
        if test $status -eq 0
            set __freddyfishy_battery_color red
        end
        # Is the AC power adapter on-line?
        acpi -a 2>&- | grep on &>-
        if test $status -eq 0
            set __freddyfishy_battery_color normal
        end
        # Are powerline fonts installed? If so use other dividers.
        if test "$theme_powerline_fonts" = "no"
            echo -n '─['
            set_color -o $__freddyfishy_battery_color
            echo -ns $__freddyfishy_battery
            set_color -o green
            __freddyfishy_closing_divider
        else if test "$theme_powerline_fonts" != "no"
            set_color -o $__freddyfishy_battery_color
            echo -ns $__freddyfishy_battery
            set_color -o green
        end
      end
    end
    set_color normal
end

function fish_right_prompt -d 'freddyfishy is all about the right prompt'
  set -l __freddyfishy_left_arrow_glyph \uE0B3
  if [ "$theme_powerline_fonts" = "no" ]
    set __freddyfishy_left_arrow_glyph '<'
  end

  set_color $fish_color_autosuggestion

  __freddyfishy_cmd_duration
#  __freddyfishy_timestamp
__freddyfishy_virtual_host
echo " "
__freddyfishy_opening_divider
__freddyfishy_date
echo " "
__freddyfishy_time
__freddyfishy_closing_divider
__freddyfishy_battery
  set_color normal
end
