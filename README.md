<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### freddyfishy
> An [Oh My Fish][omf-link], Fish shell theme whose name is inspired by my childhood nickname and the Fish shell of course. freddyfishy is a theme that I have borrowed some code from other themes, but have developed other myself. It has been influenced by my work as a Drupal developer and has a Drush integration.

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v3.1.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>


## Install

```fish
omf install freddyfishy
```
or

```fish
fisher install topdroplabs/freddyfishy
```
for older versions of `fisher` (pre-4.0) use

```fish
fisher add topdroplabs/freddyfishy
```

You will need a [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts) for the icons to work. Or you can enable the compatibility fallback option to use plain ASCII characters:

    set -g theme_powerline_fonts no



On Ubuntu Powerline fonts can be installed with:

```bash
sudo apt-get install fonts-powerline
```
## Screenshot

<p align="center">
<img src="{{SCREENSHOT_URL}}">
</p>


## Features

* Left prompt
  * username
  * host
  * path
  * git status
  * For [Drupal](https://drupal.org) Developers the left prompt will show the [Drush](https://www.drush.org/) site alias name in use. -
ie. If you run `drush use @mysite` so that all commands will be sent to "@mysite", then "@mysite" will also be shown in the left prompt.
* Right prompt
  * time at the end of the last command run
  * run time of the last command
  * For those working with [Docksal](https://docksal.io) it will show the contents of the `$VIRTUAL_HOST` variable.
* If the previous command failed the line to the left of the prompt will be red instead of the normal green.
* The Fish Greetings shows an ASCII art fish and information about the terminal session.
* Battery status, which is by default shown when not plugged into AC power and not at 100% charge.

## User Configuration

The theme can be configured to your liking. Below is a good start of what to add to your `~/.config/fish/config.fish` file.

```fish
# Themes options
     set -g theme_display_user yes
     set -g theme_display_hostname yes
     set -g theme_nerd_fonts yes
     set -g theme_powerline_fonts yes
     set -g theme_show_exit_status yes
     set -g fish_prompt_pwd_dir_length 0
     set -g theme_newline_cursor yes
     set -g default_user docker
     set -g theme_display_git_ahead_verbose yes
     set -g always_display_battery_status no  # Set this to yes to show the battery status even when full and on AC.
     set -g theme_git_worktree_support yes   #Shows git root folder, then git branch / tag / status, then sub-folders in git working tree.
     set -g theme_date_format "+%a %b %e %Y" # Sets the date format. Default is: "+%a %b %e %Y"
     set -g theme_time_format "+%X %Z"       # Sets the time format. Default is: "+%X %Z"
```

# License

[MIT][mit] © [Frederick Henderson][author] et [al][contributors]


[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/{{USER}}
[contributors]:   https://github.com/{{USER}}/theme-freddyfishy/graphs/contributors
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
