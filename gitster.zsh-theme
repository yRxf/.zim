# vim:et sts=2 sw=2 ft=zsh 
# 
# Gitster theme 
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme 
# 
# Requires the `git-info` zmodule to be included in the .zimrc file. 
_prompt_gitster_pwd() { 
  local dir1 current_dir 
  # current_dir=${PWD/#${HOME}/"~"} 
  current_dir=${(%):-%~} 
  if [[ ${current_dir} != '~' ]]; then 
    current_dir_path=${${(@j:/:M)${(@s:/:)current_dir}}%/*} 
    array=(`echo ${current_dir_path} | tr '/' ' '`) 
    for var in ${array[@]} 
    do 
      if [[ ${var[1]} != '.' ]]; then 
        dir1="${dir1}/${var[1]}" 
      else 
        dir1="${dir1}/${var[1,2]}" 
      fi 
    done 
    current_dir="${dir1#/}/${current_dir:t}" 
  fi 
  print -n "%F{white}${current_dir}" 
} 
setopt nopromptbang prompt{cr,percent,sp,subst} 
typeset -gA git_info 
if (( ${+functions[git-info]} )); then 
  zstyle ':zim:git-info:branch' format '%b' 
  zstyle ':zim:git-info:commit' format '%c' 
  zstyle ':zim:git-info:clean' format '%F{green}✓' 
  zstyle ':zim:git-info:dirty' format '%F{yellow}✗' 
  zstyle ':zim:git-info:keys' format \ 
      'prompt' ' %F{cyan}%b%c %C%D' 
  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info 
fi 
