set __outrun_toaster_color_orange ff9b50
set __outrun_toaster_color_blue 42c6ff
set __outrun_toaster_color_green a7da1e
set __outrun_toaster_color_yellow ffd400
set __outrun_toaster_color_pink ff2e97
set __outrun_toaster_color_grey 283034
set __outrun_toaster_color_white e4eeff
set __outrun_toaster_color_purple d86bff
set __outrun_toaster_color_lilac ff2afc

function __outrun_toaster_color_echo
  set_color $argv[1]
  if test (count $argv) -eq 2
    echo -n $argv[2]
  end
end

function __outrun_toaster_current_folder
  if test $PWD = '/'
    echo -n '/'
  else
    echo -n $PWD | grep -o -E '[^\/]+$'
  end
end

function __outrun_toaster_git_status_codes
  echo (git status --porcelain ^/dev/null | sed -E 's/(^.{3}).*/\1/' | tr -d ' \n')
end

function __outrun_toaster_git_branch_name
  echo (git rev-parse --abbrev-ref HEAD ^/dev/null)
end

function __outrun_toaster_rainbow
  if echo $argv[1] | grep -q -e $argv[3]
    __outrun_toaster_color_echo $argv[2] "彡ミ"
  end
end

function __outrun_toaster_git_status_icons
  set -l git_status (__outrun_toaster_git_status_codes)

  __outrun_toaster_rainbow $git_status $__outrun_toaster_color_pink 'D'
  __outrun_toaster_rainbow $git_status $__outrun_toaster_color_orange 'R'
  __outrun_toaster_rainbow $git_status $__outrun_toaster_color_white 'C'
  __outrun_toaster_rainbow $git_status $__outrun_toaster_color_green 'A'
  __outrun_toaster_rainbow $git_status $__outrun_toaster_color_blue 'U'
  __outrun_toaster_rainbow $git_status $__outrun_toaster_color_lilac 'M'
  __outrun_toaster_rainbow $git_status $__outrun_toaster_color_grey '?'
end

function __outrun_toaster_git_status
  # In git
  if test -n (__outrun_toaster_git_branch_name)

    __outrun_toaster_color_echo $__outrun_toaster_color_blue " git"
    __outrun_toaster_color_echo $__outrun_toaster_color_white ":"(__outrun_toaster_git_branch_name)

    if test -n (__outrun_toaster_git_status_codes)
      __outrun_toaster_color_echo $__outrun_toaster_color_pink ' ●'
      __outrun_toaster_color_echo $__outrun_toaster_color_white ' [^._.^]ﾉ'
      __outrun_toaster_git_status_icons
    else
      __outrun_toaster_color_echo $__outrun_toaster_color_green ' ○'
    end
  end
end

function fish_prompt
  __outrun_toaster_color_echo $__outrun_toaster_color_blue "# "
  __outrun_toaster_color_echo $__outrun_toaster_color_purple (__outrun_toaster_current_folder)
  __outrun_toaster_git_status
  echo
  __outrun_toaster_color_echo $__outrun_toaster_color_pink "\$ "
end
