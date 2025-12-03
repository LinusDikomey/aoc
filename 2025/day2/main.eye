Part :: enum {
  Part1
  Part2
}

valid :: fn(id u64, part Part) -> bool {
  id := ToString.to_string(&id)
  max_pieces := match part {
    .Part1: 2,
    .Part2: id.len,
  }
  for pieces in range(2, 1 + max_pieces) {
    if id.len % pieces != 0: continue
    part_len := id.len / pieces
    parts := map(range(0, pieces), fn(i): id.slice(i * part_len, (i + 1) * part_len))
    first := Iterator.next(&parts).unwrap()
    mismatch := false
    for other in parts {
      mismatch = mismatch or other != first
    }
    if !mismatch {
      ret false
    }
  }
  ret true
}

solve :: fn(input List[(u64, u64)], part Part) -> u64: sum(
  map(
    input.iter()
    fn(r (u64, u64)) {
      part := part
      ret sum(filter(range(r.0, r.1 + 1), fn(i): !valid(i^, part)))
    }
  )
)

main :: fn {
  input := collect(
    map(
      std.file.read_to_string("input/day2.txt").split(",")
      fn(entry str) {
        parts := entry.split("-")
        a := Iterator.next(&parts).unwrap().parse()
        b := Iterator.next(&parts).unwrap().parse()
        ret (a, b)
      }
    )
  )
  print("Part 1: ")
  println(solve(input, .Part1))
  print("Part 2: ")
  println(solve(input, .Part2))
}
