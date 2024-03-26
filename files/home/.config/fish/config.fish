function SetupMyTheme
	set -U fish_color_normal normal
	set -U fish_color_command ED900C
	set -U fish_color_keyword $fish_color_command
	set -U fish_color_quote 6090A0
	set -U fish_color_redirection $fish_color_cwd --bold
	set -U fish_color_end normal --bold
	set -U fish_color_error normal
	set -U fish_color_param $fish_color_normal
	set -U fish_color_valid_path normal --italics
	set -U fish_color_option normal --bold
	set -U fish_color_comment 656055
	set -U fish_color_selection normal --reverse
	set -U fish_color_operator normal --bold
	set -U fish_color_escape normal --bold --dim
	set -U fish_color_autosuggestion normal --dim --italics
	set -U fish_color_cwd A88E70 --bold
	set -U fish_color_cwd_root $fish_color_cwd
	set -U fish_color_user $fish_color_command
	set -U fish_color_host $fish_color_user --bold
	set -U fish_color_host_remote green
	set -U fish_color_status white --dim
	set -U __fish_git_prompt_showcolorhints yes
end

function SetupMyBinds
	bind -k btab forward-char
end

function ExtendMyPath
	fish_add_path ~/Shortcuts
end

function man
	man_emacs $argv
end

function lls
	ls -lah
end

function fish_greeting
end

SetupMyTheme
SetupMyBinds
ExtendMyPath