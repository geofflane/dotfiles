# mh theme
# preview: http://cl.ly/1y2x0W0E3t2C0F29043z

# features:
# displays git status (if applicable in current folder)

autoload -U add-zsh-hook

# TODO: Figure out how to make this on the same line as the top line of the prompt
prompt_geoff_precmd () {
  if [ -n "$(git_prompt_info)" ]; then
    # only show if we're in git so we don't get a | hanging out
    RPROMPT='$(git_prompt_info) | $(git_prompt_short_sha)'
  fi
}
add-zsh-hook precmd prompt_geoff_precmd

# prompt
local success_fail="%(?,%{$FG[033]%}∴%{$reset_color%},%{$FG[166]%}≠%{$reset_color%})"

PROMPT='
%{$FG[246]%}[%D{%Y-%m-%d} %M]:%~%{$reset_color%} $(git_prompt_status)
${success_fail}  %{$reset_color%}'


# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[242]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$FG[246]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$GIT_DIRTY_COLOR%}⚒ "
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$FG[242]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"
GIT_DIRTY_COLOR=$FG[202] #202=orange
GIT_CLEAN_COLOR=$FG[118]
GIT_PROMPT_INFO=$FG[012]

ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[044]%}α%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[178]%}δ%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[160]%}ω%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[227]%}г%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[048]%}λ%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[194]%}ϟ%{$reset_color%}"

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'
