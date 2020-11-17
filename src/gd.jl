
function run(x::Array{Float64}, n::Int, g, state, opt)
  Δs = zeros(n, size(x)...)
  xs = zeros(n, size(x)...)
  for i in 1:n
    Δ, state = opt(state, g(x))
    x = x + Δ
    Δs[i,:] = Δ
    xs[i,:] = x
  end
  return Δs, xs
end

function run_adam(x, n, g)
  init, opt = new_adam(AdamParameter(0.9, 0.999, 10^-8, 10^-3))
  return run(x, n, g, init, opt)
end

function run_adabelief(x, n, g)
  init, opt = new_adabelief(AdaBeliefParameter(0.9, 0.999, 10^-8, 10^-3))
  return run(x, n, g, init, opt)
end

function run_sgd(x, n, g)
  init, opt = new_momentum(MomentumParameter(10^-3, 0.9))
  return run(x, n, g, init, opt)
end