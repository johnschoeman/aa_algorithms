require 'byebug'
require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  hash_map = HashMap.new

  string.split("").each do |ch|
    if hash_map.include?(ch)
      hash_map[ch] += 1
    else
      hash_map[ch] = 1
    end
  end
  odd_count = 0
  hash_map.each do |k, v|
    odd_count += 1 if v.odd?
  end
  odd_count <= 1
end
