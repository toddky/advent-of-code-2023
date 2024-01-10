#!/usr/bin/env bash
# TODO: https://www.youtube.com/watch?v=QE5c_bWyJ-k

input='example.txt'
rm -f answer.txt

cat > a.vim <<-EOF
yyPVr.
GyypVr.
ggGI.
gg$GA.
:w answer.txt
:q!
EOF

echo '================================================================================'
cat a.vim
echo '================================================================================'

nvim -u NONE -s a.vim "$input"
cat answer.txt
rm -f a.vim answer.txt

