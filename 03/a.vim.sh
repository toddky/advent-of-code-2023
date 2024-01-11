#!/usr/bin/env bash
# TODO: https://www.youtube.com/watch?v=QE5c_bWyJ-k

input='input.txt'
input='example.txt'
rm -f a.vim answer.txt

cat > a.vim <<EOF
:set nowrapscan
yyPVr.
GyypVr.
ggGI.
gg$GA.
ggO
ggma/\d\+
qq\`anmakhjlejlyggOggPJxJx@qq
@q
Gdap

:v/[^\.0-9]/d
:%s/[^0-9]//g
:%s/\n/+/
\$x
S="

:w answer.txt
:q!
EOF

echo '================================================================================'
cat a.vim
echo '================================================================================'

nvim -u NONE -s a.vim "$input"
cat answer.txt
rm -f a.vim answer.txt

