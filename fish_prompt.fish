function __freddyfishy_drush_alias_name
    set -l pid %self
    if test -f "$TMPDIR/drush-env/drush-drupal-site-$pid"
        echo (command cat $TMPDIR/drush-env/drush-drupal-site-$pid)
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
    echo -n :(pwd|sed "s=$HOME=~=")
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
    set -g __fish_git_prompt_char_dirtystate '⚡'
    set -g __fish_git_prompt_char_stagedstate '→'
    set -g __fish_git_prompt_char_stashstate '↩'
    set -g __fish_git_prompt_char_upstream_ahead '↑'
    set -g __fish_git_prompt_char_upstream_behind '↓'

    __freddyfishy_line1start
    __freddyfishy_opening_divider
    __freddyfishy_user
    __freddyfishy_at
    __freddyfishy_host
    __freddyfishy_pwd
    __freddyfishy_closing_divider

    set -g git_dir (git rev-parse --git-dir 2>&-)
    if test -n "$git_dir"
        parse_git_branch
        printf '%s ' (fish_git_prompt)
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
