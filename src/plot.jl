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
    for (j, (name, traj)) in enumerate(trajectories)
      p = Plots.plot!(
        p,
        traj[1:i,1],
        traj[1:i,2],
        label=missing,
        color=colors[j],
      )
      p = Plots.scatter!(
        p,
        [traj[i,1]],
        [traj[i,2]],
        color=colors[j],
        label=name,
      )
    end
    p
  end every 50
  Plots.gif(anim, out_file, fps=15)
end
