#!/usr/bin/env ruby
file = ARGV[0] || 'input.txt'
#file = ARGV[0] || 'example.txt'

sum = 0
File.readlines(file).each { |line|
  games = line.sub(/Game (\d+): +/, '')
  id = $1
  good = true
  games.split(';').each { |game| 
    puts
    p game
    green = /(\d+) green/.match(game)
    if green then
      if green[1].to_i > 13 then
        good = false
      end
    end

    green = /(\d+) blue/.match(game)
    if green then
      if green[1].to_i > 14 then
        good = false
      end
    end

    green = /(\d+) red/.match(game)
    if green then
      if green[1].to_i > 12 then
        good = false
      end
    end

  }
  if good then
    sum += id.to_i
    puts "GOOD: #{id}"
  end
}
p sum

#p File.readlines(file).map { |line| (line[/\d/] + line.reverse[/\d/]).to_i }.inject(:+)


