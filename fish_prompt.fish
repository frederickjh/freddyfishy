set -g fish_theme freddyfishy
function __freddyfishy_drush_alias_name
    set -l pid %self
    if test -f "$TMPDIR/drush-env/drush-drupal-site-$pid"
        echo (command cat $TMPDIR/drush-env/drush-drupal-site-$pid)
    end
end
# VirtualFish environment prompt for Python virtualenv.
#https://virtualfish.readthedocs.io/en/latest/install.html#customizing-your-fish-prompt
function __freddyfishy_python_virtualenv
  if set -q VIRTUAL_ENV
    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
  end
end
# http://zogovic.com/post/37906589287/showing-git-branch-in-fish-shell-prompt
# https://gist.github.com/davidmh/721241c7c34f841eed07
# https://gist.github.com/diezguerra/4737141
function __freddyfishy_parse_git_branch
    set fish_git_dirty_color red
    set fish_git_not_dirty_color green
  set -g branch (git branch 2>&- | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -g git_diff (git diff 2>&-)
  if test -z "$git_diff"
    echo -n (set_color $fish_git_not_dirty_color)
  else
    echo -n (set_color $fish_git_dirty_color)
      end
end
function __freddyfishy_line1start
    if [ $tty = tty ]
        echo -n .-
    else
        echo -n '┬─'
    end
    set_color normal
end
function __freddyfishy_opening_divider
    set_color -o green
    echo -n '['
    set_color normal
end
function __freddyfishy_closing_divider
   set_color -o green
   echo -n ']'
   set_color normal
end
function __freddyfishy_middle_divider
    set_color -o green
    echo -n ]
    set_color -o green
    if [ $tty = tty ]
        echo -n '-'
    else
        echo -n '─'
    end
    echo -n [
    set_color normal
end
function __freddyfishy_at
    set_color -o white
    echo -n @
    set_color normal
end
function __freddyfishy_user 
    if [ $USER = root ]
        set_color -o red
    else
        set_color -o cyan
    end
    echo -n $USER
    set_color normal
end
function __freddyfishy_host
    if [ -z "$SSH_CLIENT" ]
        set_color -o blue
    else
        set_color -o cyan
    end
    echo -n (hostname)
    set_color normal
end
function __freddyfishy_pwd
    set_color -o purple
    printf '%s' (prompt_pwd)
#    echo -n :(pwd|sed "s=$HOME=~=")
    set_color normal
end
function __freddyfishy_jobs
    for job in (jobs)
        set_color $retc
        if [ $tty = tty ]
            echo -n '; '
        else
            echo -n '│ '
        end
        set_color brown
        echo $job
    end
    set_color normal
end

function fish_prompt
    and set retc green; or set retc red
    set -g tty
    tty|grep -q tty; and set tty tty; or set tty pts
    set_color $retc
    # fish git prompt
    set -g __fish_git_prompt_show_status 1
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_char_upstream_prefix ""
    set -g __fish_git_prompt_showdirtystate 'yes'
    set -g __fish_git_prompt_showstashstate 'yes'
    set -g __fish_git_prompt_showupstream 'yes'
    set -g __fish_git_prompt_showuntrackedfiles 'yes'
    set -g __fish_git_prompt_showcolorhints 'yes'
    set -g __fish_git_prompt_show_informative_status 'yes'
    set -g __fish_git_prompt_color_branch yellow
    # Status Chars
    if test "$theme_powerline_fonts" = yes
        set -g __fish_git_prompt_char_dirtystate \u26A1 #'⚡'
        set -g __fish_git_prompt_char_stagedstate \u2192\u200A #'→'
        set -g __fish_git_prompt_char_stashstate \u21A9\u200A #'↩'
        set -g __fish_git_prompt_char_upstream_ahead \u2191\u200A # '↑'
        set -g __fish_git_prompt_char_upstream_behind \u2193\u200A #'↓'
        set -g __fish_git_prompt_char_cleanstate \u2714\u200A #'✔'
    end

    __freddyfishy_line1start
    __freddyfishy_opening_divider
    __freddyfishy_user
    __freddyfishy_at
    __freddyfishy_host
    __freddyfishy_pwd
    __freddyfishy_closing_divider

    set -g git_dir (git rev-parse --git-dir 2>&-)
    if test -n "$git_dir"
        __freddyfishy_parse_git_branch

        if test (functions -q fish_git_prompt)
          printf '%s ' (fish_git_prompt)
        else
          printf '%s ' (__fish_git_prompt)
        end
    end
    if [ (__freddyfishy_drush_alias_name) ]
        set -l drush_alias (__freddyfishy_drush_alias_name)
        set -l drush_info "$drush_alias"
        set_color black
        echo -n $drush_info
    end

    set_color normal
    set_color $retc
    echo
    set_color normal
    __freddyfishy_jobs
    set_color $retc
    if [ $tty = tty ]
        echo -n "'->"
    else
        echo -n '╰─>'
    end
    set_color -o red
    echo -n '$ '
    set_color normal
end
