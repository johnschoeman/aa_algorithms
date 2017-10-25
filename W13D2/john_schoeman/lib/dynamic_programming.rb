require 'byebug'
class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = { 1 => [[1]], 2 => [[1,1],[2]], 3 => [[1,1,1], [1,2], [2,1], [3]] }
    @maze_cache = []
  end

  # top down
  def blair_nums(n)
    return n if n == 1 || n == 2
    return @blair_cache[n] if @blair_cache[n]
    @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + (2*n - 3)
  end

  # bottom up
  # def blair_cache(n)
  #   cache = { 1 => 1, 2 => 2}
  #   return cache if n < 3
  #   (3..n).each do |i|
  #     cache[i] = cache[i-1] + cache[i-2] + (2*i - 3)
  #   end
  #   cache
  # end

  # def blair_nums(n)
  #   blair_cache(n)[n]
  # end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end
  
  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    n3 = frog_hops_top_down_helper(n - 3)
    n2 = frog_hops_top_down_helper(n - 2)
    n1 = frog_hops_top_down_helper(n - 1)
    next_arr = []
    n1.each do |j|
      next_arr << [1] + j
    end
    n2.each do |j|
      next_arr << [2] + j
    end
    n3.each do |j|
      next_arr << [3] + j
    end
    @frog_cache[n] = next_arr
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    frog_cache = { 1 => [[1]], 
                   2 => [[1,1],[2]], 
                   3 => [[1,1,1], [1,2], [2,1], [3]] }
    return frog_cache if n < 4
    (4..n).each do |i|
      next_arr = []
      frog_cache[i - 1].each do |j|
        next_arr << [1] + j
      end
      frog_cache[i - 2].each do |j|
        next_arr << [2] + j
      end
      frog_cache[i - 3].each do |j|
        next_arr << [3] + j
      end
      frog_cache[i] = next_arr
    end
    frog_cache
  end

  def super_frog_hops(num_stairs, max_stairs)
    # get base cases
    super_cache = super_frog_base_cases(max_stairs)

    return super_cache[num_stairs] if num_stairs <= max_stairs

    # iterate from the last base case upto the desired num_stairs, saving work into the cache
    (max_stairs+1..num_stairs).each do |stair_count|
      next_jump_combinations = []
      # get the the kth previous solutions to build next set of jump combinations
      (1..max_stairs).each do |next_jump|
        super_cache[stair_count - next_jump].each do |jump_combination|
          next_jump_combinations << [next_jump] + jump_combination
        end
      end
      super_cache[stair_count] = next_jump_combinations
    end

    super_cache[num_stairs]
  end

  # Finds initial base cases for frogs that can jump all steps 1 up to k.
  def super_frog_base_cases(k)
    return { 1 => [[1]] } if k == 1
    add_next_base_case(super_frog_base_cases(k-1), k)
  end

  # builds the next base case off the k - 1th base case
  def add_next_base_case(prev_base_case, k)
    next_case = []
    (1...k).each do |i|
      prev_base_case[i].each do |j|
        next_case << [k - i] + j
      end
    end
    prev_base_case[k] = next_case + [[k]]
    prev_base_case
  end


  def knapsack(weights, values, capacity)
    t = Array.new(weights.length) { Array.new(capacity + 1) }
    
    (0..capacity).each do |cap|
      if cap < weights[0]
        t[0][cap] = 0
      else
        t[0][cap] = values[0]
      end
    end

    (0..capacity).each do |cap|
      (1...weights.length).each do |wt_idx|
        if cap < weights[wt_idx]
          t[wt_idx][cap] = t[wt_idx - 1][cap]
        else
          with_item = values[wt_idx] + t[wt_idx - 1][cap - weights[wt_idx]]
          without_item = t[wt_idx - 1][cap]
          t[wt_idx][cap] = [with_item, without_item].max
        end
      end
    end

    t[-1][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, finish_pos)
    # Call populate_maze_cache to set up the maze cache
    # Call and return or parse the result of solve_maze

  end



  private
  def populate_maze_cache(maze)
    # Create a maze_cache of the correct size
    # Record base case(s) in the cache
  end

  def solve_maze(maze, start_pos, finish_pos)
    # Do the actual work of solving the maze
  end
end
