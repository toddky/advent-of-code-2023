
## Tips

- [Advent of Code Charts](https://chromewebstore.google.com/detail/advent-of-code-charts/ipbomkmbokofodhhjpipflmdplipblbe) Chrome plugin
- [Going Fast](https://kevinyap.ca/2019/12/going-fast-in-advent-of-code/)
- [Go Fast](https://gist.github.com/mcpower/87427528b9ba5cac6f0c679370789661)
    - Language matters. Pick a concise scripting language.
    - Regex doesn't need to be very strict.
    - Don't validate inputs.
    - [Custom CSS](https://gist.github.com/mcpower/e224e66699a3bfe774e9eee2fe43bb8a) to make website more readable.
    - [User script to copy code blocks.](https://gist.github.com/mcpower/87427528b9ba5cac6f0c679370789661?permalink_comment_id=4392058#gistcomment-4392058)

## Examples

- Start script
    - [antooro (Python)][https://github.com/antooro/advent-of-code-2019/blob/0f730756c2ee010ba062bf58879bae503ac41e7c/startDay.py]

## Lessons

- **Check your inputs.** I accidentally parsed out all of the negative signs for [2023 day 9](https://adventofcode.com/2023/day/9). LCM was good enough for [2023 day 8 part 2](https://adventofcode.com/2023/day/8).
- TODO: Implement grid commands for directions like North, South, East, West, etc.
- **Get good.**. Need to get beter at coming up with stuff on the fly, e.g.
    - Subtracting an array from itself shifted over one: `n[1..-1].mapi{|x,i| x-n[i]}`
- [Encode your logic in a hash](https://github.com/Evgenus/advent-of-code/blob/0f53db49d485d2a9884ac3fee2d86d8e88dbdda8/2023/16/main.py#L12) instead of doing a bunch of if statements.

