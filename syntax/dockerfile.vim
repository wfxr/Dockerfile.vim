" dockerfile.vim - Syntax highlighting for Dockerfiles
" Maintainer:   Honza Pokorny <https://honza.ca>
" Version:      0.5


if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "dockerfile"

syntax case ignore

syntax match dockerfileKeyword /\v^\s*(ONBUILD\s+)?(ADD|ARG|CMD|COPY|ENTRYPOINT|ENV|EXPOSE|FROM|HEALTHCHECK|LABEL|MAINTAINER|RUN|SHELL|STOPSIGNAL|USER|VOLUME|WORKDIR)\s/
syntax keyword dockerfileKeyword AS
highlight link dockerfileKeyword Keyword

syntax region dockerfileString start=/\v"/ skip=/\v\\./ end=/\v"/
highlight link dockerfileString String

syntax match dockerfileComment "\v^\s*#.*$"
highlight link dockerfileComment Comment

set commentstring=#\ %s

" match "RUN", "CMD", and "ENTRYPOINT" lines, and parse them as shell
let s:current_syntax = b:current_syntax
unlet b:current_syntax
setlocal iskeyword+=-
setlocal iskeyword+=/
syn keyword bashStatement add-apt-repository adduser apk apt-get aptitude apt-key autoconf bundle
syn keyword bashStatement cd chgrp chmod chown clear complete composer cp curl du echo egrep
syn keyword bashStatement expr fgrep find gem gnufind gnugrep gpg grep groupadd head less ln
syn keyword bashStatement ls make mkdir mv node npm pacman pip pip3 php python rails rm rmdir rpm ruby
syn keyword bashStatement sed sleep sort strip tar tail tailf touch useradd virtualenv yum
syn keyword bashStatement usermod bash cat a2ensite a2dissite a2enmod a2dismod apache2ctl
syn keyword bashStatement wget gzip go cargo mvn gradle
syntax include @SH syntax/sh.vim
let b:current_syntax = s:current_syntax
syntax region shLine matchgroup=dockerfileKeyword start=/\v^\s*(RUN|CMD|ENTRYPOINT)\s/ end=/\v$/ contains=@SH
" since @SH will handle "\" as part of the same line automatically, this "just works" for line continuation too, but with the caveat that it will highlight "RUN echo '" followed by a newline as if it were a block because the "'" is shell line continuation...  not sure how to fix that just yet (TODO)

" vim: ft=vim:
