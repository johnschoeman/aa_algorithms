def file_list(file, curr_path = '', res = [])
  curr_keys = file.keys
  if curr_keys.length == 1
    if file[curr_keys[0]].class != Hash
      res.push(curr_path + "#{curr_keys[0]}")
      return res
    end
  end
  curr_keys.each do |k|
    if file[k].class != Hash
      res.push(curr_path + "#{k}")
    else
      curr_path += "#{k}/"
      res = file_list(file[k], curr_path, res)
    end
  end
  return res
end 

file = {'a' => { 'b' => { 'c' => { 'd' => { 'e' => true } }, 'f' => true}}}