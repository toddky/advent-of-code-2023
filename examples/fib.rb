#!/usr/bin/env ruby
# vim: ft=ruby noet ts=4 sw=0 sts
require_relative '../todd'

fib = Hash.new{|h,k| h[k] = k < 2 ? k : h[k-1] + h[k-2]}

def fib(n)
	return n if n == 0 || n == 1
	return fib(n-1) + fib(n-2)
end

memoize(:fib)
p fib(33)
p fib[33]
p fib(150)
p fib[150]

