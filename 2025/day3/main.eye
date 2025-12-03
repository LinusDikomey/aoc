pow :: fn(x u64, y u64) -> u64: if y == 0: 1 else pow(x, y - 1) * x

max_joltage_n :: fn(bank str, n u64) -> (u64, u64) {
  max := 0
  max_i := 0
  submax := .None
  for i in range(0, bank.len - n + 1) {
    a := (bank.byte(i) - std.string.ASCII_ZERO) as u64
    v := a
    if n > 1 {
      v *= pow(10, n - 1)
      if .Some((sub_v, sub_i)) := submax {
        if sub_i <= i {
          submax = .None
        }
      }
      if .Some((sub_v, sub_i)) := submax {
        v += sub_v
      } else {
        (sub_v, sub_i) := max_joltage_n(bank.slice(i + 1, bank.len), n - 1)
        sub_i += i + 1
        submax = .Some((sub_v, sub_i))
        v += sub_v
      }
    }
    if v >= max {
      max = v
      max_i = i
    }
  }
  ret (max, max_i)
}

main :: fn {
  input := collect(std.file.read_to_string("input/day3.txt").split("\n"))
  print("Part 1: ")
  println(sum(map(input.iter(), fn(bank): max_joltage_n(bank, 2).0)))
  print("Part 2: ")
  println(sum(map(input.iter(), fn(bank): max_joltage_n(bank, 12).0)))
}
