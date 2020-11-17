import AdaBelief

conditions = [
  (
    "Fig.3(c).gif",
    ((x, y),) -> (x + y) ^ 2 + ((x - y) ^ 2) / 10,
    ((x, y),) -> [
        11 / 5 * x + 18 / 10 * y,
        11 / 5 * y + 18 / 10 * x,
      ],
    (-3., 3.),
    [2.5, 0.],
  ),
  (
    "Fig.3(a).gif",
    ((x, y),) -> abs(x) + abs(y),
    (x) -> sign.(x),
    (-3., 3.),
    [-2.5, 0.],
  ),
]

for c in conditions
  AdaBelief.plt(c...)
end