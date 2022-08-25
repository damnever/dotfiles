function fish_greeting
    echo $(printf (_ 'Type %shelp%s for instructions on how to use fish shell.') (set_color green) (set_color normal))
end
