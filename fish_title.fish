function fish_title --description "Set the terminal title."
    if test -z $VIRTUAL_HOST
        echo "$USER@$HOSTNAME:"(string replace "$HOME" "~" "$PWD")
    else
        echo "$VIRTUAL_HOST"-"$USER@$HOSTNAME:"(string replace "$HOME" "~" "$PWD")
    end
end
