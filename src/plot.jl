import Plots

colors = [
  :red,
  :blue,
  :green,
  :cyan3,
  :magenta3,
  :yellow3,
]

function plt(out_file, f, g, def, start)
  n = 5000
  def = (-3., 3.)
  start = [2.5, 0.]
  runners = Dict([
    ("AdaBelief", run_adabelief),
    ("Adam", run_adam),
    ("Momentum", run_sgd),
  ])
  trajectories = Dict(
    name => runner(start, n, g)[2] for (name, runner) ∈ runners
  )
  tt = range(def[1], stop=def[2], length=100)
  anim = @Plots.animate for i ∈ 2:n
    p = Plots.contour(
      tt, tt,
      (x, y) -> f([x, y]),
      xlim=def,
      ylim=def,
      aspect_ratio=1,
    )
    for (name, traj) in trajectories
      p = Plots.plot!(
        p,
        traj[1:i,1],
        traj[1:i,2],
        label=name,
      )
    end
    p
  end every 50
  Plots.gif(anim, out_file, fps=15)
end
