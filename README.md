
Tips
--------------------------------------------------------------------------------
- [Advent of Code Charts](https://chromewebstore.google.com/detail/advent-of-code-charts/ipbomkmbokofodhhjpipflmdplipblbe) Chrome plugin
- [Going Fast](https://kevinyap.ca/2019/12/going-fast-in-advent-of-code/)
- [Go Fast](https://gist.github.com/mcpower/87427528b9ba5cac6f0c679370789661)
    - Language matters. Pick a concise scripting language.
    - Regex doesn't need to be very strict.
    - Don't validate inputs.
    - [Custom CSS](https://gist.github.com/mcpower/e224e66699a3bfe774e9eee2fe43bb8a) to make website more readable.
    - [User script to copy code blocks.](https://gist.github.com/mcpower/87427528b9ba5cac6f0c679370789661?permalink_comment_id=4392058#gistcomment-4392058)

Examples
--------------------------------------------------------------------------------
- Start script
    - [antooro (Python)][https://github.com/antooro/advent-of-code-2019/blob/0f730756c2ee010ba062bf58879bae503ac41e7c/startDay.py]
    - [bcc32 (Bash)](https://github.com/bcc32/advent-of-code/blob/main/start.sh)
- [Using complex numbers as coordinates.](https://github.com/rabuf/advent-of-code/blob/a21f1b84785f198c7c28975fdb7f8a184d374019/python/aoc2023/day18.py)
- 2023 day 1 part 1 in [RISC-V assembly](https://gitlab.com/paulmkennedy/aoc/-/blob/master/2023/day01/risc-v/part1.S)
- Templates
    - [davidsharick](https://gitlab.com/davidsharick/advent-of-code-2023/-/blob/main/skel.py?ref_type=heads)


Lessons
--------------------------------------------------------------------------------
- **Check your inputs.** I accidentally parsed out all of the negative signs for [2023 day 9](https://adventofcode.com/2023/day/9). LCM was good enough for [2023 day 8 part 2](https://adventofcode.com/2023/day/8).
- TODO: Implement grid commands for directions like North, South, East, West, etc.
- **Get good.**. Need to get beter at coming up with stuff on the fly, e.g.
    - Subtracting an array from itself shifted over one: `n[1..-1].mapi{|x,i| x-n[i]}`
- [Encode your logic in a hash](https://github.com/Evgenus/advent-of-code/blob/0f53db49d485d2a9884ac3fee2d86d8e88dbdda8/2023/16/main.py#L12) instead of doing a bunch of if statements.
- Or you can [write your own language](https://www.uiua.org/pad?src=0_7_0__JCBPLi4uLiMuLi4uCiQgTy5PTyMuLi4uIwokIC4uLi4uIyMuLi4KJCBPTy4jTy4uLi5PCiQgLk8uLi4uLk8jLgokIE8uIy4uTy4jLiMKJCAuLk8uLiNPLi5PCiQgLi4uLi4uLk8uLgokICMuLi4uIyMjLi4KJCAjT08uLiMuLi4uCgpSb2xsIOKGkCDiiaHijZziipzilqHiiLXijZzCsOKWoSjiio_ijZYuKeKJoDIuCkxvYWQg4oaQIC8r4pmt4omhKMOXKzHih6Hip7suPTApCuKKnOKImOKJoDMu4oqbCjpMb2FkIFJvbGwu4omh4oeM4o2JICMgcGFydCAxCgrijaLiioMo4o2lKOKJoeKHjOKNiVJvbGwpNHziioI64pahKSjCrOKIiuKWoSk6W10KK-KXv-KIqSgtOiniioMo4ouF4qe7fCwxZTku4oqX4pahfOKLheKImCkK4oqQTG9hZOKKjyAjIHBhcnQgMgo=)!


Top Finishers' GitHub
--------------------------------------------------------------------------------
- [danielhuang](https://github.com/danielhuang/aoc-2023) using Rust

