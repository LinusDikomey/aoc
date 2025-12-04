
main :: fn {
  input := collect(
    map(
      std.file.read_to_string("input/day4.txt").split("\n")
      fn(line str): collect(map(range(0, line.len), fn(i): line.byte(i) == "@".ptr^))
    )
  )
  print("Part 1: ")
  println(remove_rolls(&input, true))
  print("Part 2: ")
  count := 0
  while true {
    removed := remove_rolls(&input, false)
    if removed == 0: break
    count += removed
  }
  println(count)
}

remove_rolls :: fn(input *List[List[bool]], removed_value bool) -> u64 {
  count := 0
  w := input.get(0).len as i64
  h := input.len as i64
  for y in range(0, h as u64) {
    for x in range(0, w as u64) {
      if !input.get(y).get(x): continue
      neighbors := 0
      for dy in range(0, 3) {
        for dx in range(0, 3) {
          if dx == 1 and dy == 1: continue
          x := x as i64 + dx as i64 - 1
          y := y as i64 + dy as i64 - 1
          if x < 0 or x >= w or y < 0 or y >= h: continue
          if input.get(y as _).get(x as _): neighbors += 1
        }
      }
      if neighbors < 4 {
        count += 1
        input.get(y).get_ptr(x)^ = removed_value
      }
    }
  }
  ret count
}
