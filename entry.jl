import AdaBelief

conditions = [
  (
    "figures/paper/Fig.3(a).gif",
    ((x, y),) -> abs(x) + abs(y),
    (x) -> sign.(x),
    (-3., 3.),
    [-2.5, 0.],
  ),
  (
    "figures/paper/Fig.3(b).gif",
    ((x, y),) -> abs(x+y) + abs(x-y)/10.,
    ((x, y),) -> [
      sign(x+y) + sign(x-y)/10.,
      sign(x+y) - sign(x-y)/10.,
    ],
    (-3., 3.),
    [2.5, 0.],
  ),
  (
    "figures/paper/Fig.3(c).gif",
    ((x, y),) -> (x + y) ^ 2 + ((x - y) ^ 2) / 10.,
    ((x, y),) -> [
        11. / 5. * x + 18. / 10. * y,
        11. / 5. * y + 18. / 10. * x,
      ],
    (-3., 3.),
    [2.5, 0.],
  ),
  (
    "figures/paper/Fig.3(e).gif",
    ((x, y),) -> (1.5 - x + x * y)^2 + (2.25 - x + x * y^2)^2 + (2.625 - x + x * y^3)^2,
    ((x, y),) -> [
        (
          2(1.5 - x + x * y) * (-1 + y) +
          2(2.25 - x + x * y^2) * (-1 + y^2) +
          2(2.625 - x + x * y^3) * (-1 + y^3)
        ),
        (
          2(1.5 - x + x * y) * x +
          2(2.25 - x + x * y^2) * (2 * x * y) +
          2(2.625 - x + x * y^3) * (3 * x * y^2)
        ),
      ],
    (-3., 3.),
    [-2.5, -2.5],
  ),
  (
    "figures/paper/Fig.3(f).gif",
    ((x, y),) -> (1. - x)^2 + 100(y - x^2)^2,
    ((x, y),) -> [
        (
          2(1. - x) * (-1) +
          200(y - x^2) * (-2x)
        ),
        (
          200(y - x^2)
        ),
      ],
    (-6., 6.),
    [-4., -4.],
  ),
]

for c in conditions
  AdaBelief.plt(c...)
end