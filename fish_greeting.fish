# original from https://gist.github.com/kutyel/7933b9f9b806987cec8de0fc7d20f646
function fish_greeting
set -l system (uname -mrs)
set -l terminal (tty | sed -e 's/.*tty\(.*\)/\1/')
    echo '                 '(set_color F00)'___
  ___======____='(set_color FF7F00)'-'(set_color FF0)'-'(set_color FF7F00)'-='(set_color F00)')
/T            \_'(set_color FF0)'--='(set_color FF7F00)'=='(set_color F00)')    '(set_color red)(whoami)(set_color yellow)'@'(set_color white)(hostname)'
[ \ '(set_color FF7F00)'('(set_color FF0)'0'(set_color FF7F00)')   '(set_color F00)'\~    \_'(set_color FF0)'-='(set_color FF7F00)'='(set_color F00)')'(set_color yellow)'    Uptime:'(set_color white)(uptime | sed 's/.*up \([^,]*\), .*/\1/')(set_color red)'
 \      / )J'(set_color FF7F00)'~~    \\'(set_color FF0)'-='(set_color F00)')    Theme: '(set_color white)(echo $fish_theme)(set_color red)'
  \\\\___/  )JJ'(set_color FF7F00)'~'(set_color FF0)'~~   '(set_color F00)'\)     '(set_color yellow)'Version: '(set_color white)(echo $FISH_VERSION)(set_color red)'
   \_____/JJJ'(set_color FF7F00)'~~'(set_color FF0)'~~    '(set_color F00)'\\    Running: '(set_color white)(echo $system)(set_color red)'
   '(set_color FF7F00)'/ '(set_color FF0)'\  '(set_color FF0)', \\'(set_color F00)'J'(set_color FF7F00)'~~~'(set_color FF0)'~~     '(set_color FF7F00)'\\   '(set_color yellow)'Terminal: '(set_color white)(echo $terminal)(set_color red)'
  (-'(set_color FF0)'\)'(set_color F00)'\='(set_color FF7F00)'|'(set_color FF0)'\\\\\\'(set_color FF7F00)'~~'(set_color FF0)'~~       '(set_color FF7F00)'L_'(set_color FF0)'_
  '(set_color FF7F00)'('(set_color F00)'\\'(set_color FF7F00)'\\)  ('(set_color FF0)'\\'(set_color FF7F00)'\\\)'(set_color F00)'_           '(set_color FF0)'\=='(set_color FF7F00)'__
   '(set_color F00)'\V    '(set_color FF7F00)'\\\\'(set_color F00)'\) =='(set_color FF7F00)'=_____   '(set_color FF0)'\\\\\\\\'(set_color FF7F00)'\\\\
          '(set_color F00)'\V)     \_) '(set_color FF7F00)'\\\\'(set_color FF0)'\\\\JJ\\'(set_color FF7F00)'J\)
                      '(set_color F00)'/'(set_color FF7F00)'J'(set_color FF0)'\\'(set_color FF7F00)'J'(set_color F00)'T\\'(set_color FF7F00)'JJJ'(set_color F00)'J)
                      (J'(set_color FF7F00)'JJ'(set_color F00)'| \UUU)
                       (UU)'(set_color normal)
echo ""
echo $fish_greeting
end
