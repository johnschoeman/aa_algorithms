# Dynamic Programming

---
Improving performance of your solutions using methods that reuse work that you've already done!


---
## Two different paradigms

---
### Top-down
* Often referred to as 'memoization'
* Typical of recursive implementations that depend on solutions further down the chain
* Build your stacks and save the work to a cache as you bubble up - subsequent calls to the same function within any given stack can pull the answer out of the cache without incurring more function calls.

---
### Bottom-up
* Uses smaller solutions as the basis of later/larger solutions
* Typical of iterative implementations
* Can use a cache as well, but builds it from the ground up without incurring additional stacks

---
### Fibonacci

```ruby
def fibonacci(n)
  return 1 if n == 1 || n == 2
  return fibonacci(n - 1) + fibonacci(n - 2)
end
```

Why is this not great?

---
### Top-down Fibonacci

```ruby
class Fibonacci
  def initialize
    @cache = { 1 => 1, 2 => 1 }
  end

  def fibonacci(n)
    # return 1 if n == 1 || n == 2
    # Check our cache instead of the original base case
    return @cache[n] if @cache[n]

    # Record our answer in our cache before returning it
    ans = fibonacci(n - 1) + fibonacci(n - 2)
    @cache[n] = ans
    ans
  end
end
```

---
### Bottom-up Fibonacci

```ruby
def fib_cache_builder(n)
  # Builds the cache, starting at 1 and ending at n
  cache = { 1 => 1, 2 => 1 }
  return cache if n < 3
  (3..n).each do |i|
    cache[i] = cache[i - 1] + cache[i - 2]
  end

  cache
end

def fibonacci(n)
  # Calls the helper function
  cache = fib_cache_builder(n)
  # Returns the nth entry
  cache[n]
end
```

---
### Longest Increasing subsequence

Given an array of integers, find the length of the longest increasing subsequence.

Ex: [1,5,2,6,10,4,20] => 5, [1,2,6,10,20]

---
Let's take a bottom-up approach, which says that perhaps the solution at any given point may be based on the solutions that preceded it.

* What is the solution of [1,5]?
* What is the solution of [1,5,2]?
* What is the solution of [1,5,2,6]?
* What is the solution of [1,5,2,6,10]?
* What is the solution of [1,5,2,6,10,4]?
* What is the solution of [1,5,2,6,10,20]?
---

At each index, the solution is the longest preceding solution that terminates in a number less than the number we are considering (plus the current number).

If we accumulate the optimal solutions for every index, we can then choose among them.

---

```ruby
def longest_sub(arr)

  # Create an array of length arr.size to store the longest
  # subsequence which terminates at each index
  longest = Array.new(arr.size) { Array.new }

  # Base case
  longest[0] << arr[0]

  # Starting at 1 iterate through the longest sequences up
  # to that point
  (1...arr.size).each do |i|
    (0...i).each do |j|

      # As we iterate up to i, if arr[i] is less than arr[j]
      # and if what we have stored as the candidate for
      # longest[i] is shorter than what we could make by
      # selecting a new sequence, then we store that as
      # the longest[i] (must dup it)
      if arr[j] < arr[i] && longest[i].size < longest[j].size + 1
        longest[i] = longest[j].dup
      end
    end

    # Once we have determined the longest qualifying sequence
    # up to i, we append arr[i] onto it; thus we store the
    # longest increasing subsequence that terminates at i
    longest[i] << arr[i]
  end

  # Selecting the longest one and returning its length
  longest.max_by(&:length).length
end
```

---
Remember that the key to solving these types of problem is defining the recursive relationship:

**What is the relationship between a given solution and other solutions that lead up to it?**
