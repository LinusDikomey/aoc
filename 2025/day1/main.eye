
Dir :: enum {
  L
  R
}

main :: fn {
  input_text := std.file.read_to_string("input/day1.txt")
  input := collect(
    map(
      input_text.split("\n")
      fn(line str) {
        dir := line.slice(0, 1)
        count := line.slice(1, line.len)
        ret (match dir {
          "L": -1,
          "R": 1,
        }) * count.parse()
      }
    )
  )

  print("Part 1: ")
  dial := 50
  count := 0
  for x in input.iter() {
    dial += x
    dial %= 100
    while dial < 0: dial += 100
    if dial == 0: count += 1
  }
  println(count)
  print("Part 2: ")
  dial := 50
  count := 0
  for x in input.iter() {
    last := dial
    dial += x
    while dial >= 100 {
      dial -= 100
      count += 1
    }
    while dial < 0 {
      if last != 0 {
        count += 1
      }
      dial += 100
      last = dial
    }
    if x < 0 and dial == 0: count += 1
  }
  println(count)
}
