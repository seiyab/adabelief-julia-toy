
struct Parameter
  β_1::Float64
  β_2::Float64
  ε::Float64
  α::Float64
end

struct AdaBeliefState
  t::Int64
  m::Union{Float64, Array{Float64}}
  s::Union{Float64, Array{Float64}}
end

const AdaBeliefParameter = Parameter

function new_adabelief(p::AdaBeliefParameter)
  init = AdaBeliefState(0, 0., 0.)
  function adabelief(state::AdaBeliefState, grad::Array{Float64})::Tuple{Array{Float64}, AdaBeliefState}
    t = state.t + 1
    m = p.β_1 * state.m .+ (1 - p.β_1) * grad
    s = p.β_2 * state.s .+ (1 - p.β_2) * (grad - m) .^ 2

    m_hat = m / (1 - p.β_1 ^ t)
    s_hat = s / (1 - p.β_2 ^ t)

    Δ = - p.α * m_hat ./ (.√(s_hat) .+ p.ε)

    new_state = AdaBeliefState(t, m, s)

    return (Δ, new_state)
  end
  return (init, adabelief)
end

struct AdamState
  t::Int64
  m::Union{Float64, Array{Float64}}
  v::Union{Float64, Array{Float64}}
end

const AdamParameter = Parameter

function new_adam(p::AdamParameter)
  init = AdamState(0, 0., 0.)
  function adabelief(state::AdamState, grad::Array{Float64})::Tuple{Array{Float64}, AdamState}
    t = state.t + 1
    m = p.β_1 * state.m .+ (1 - p.β_1) * grad
    v = p.β_2 * state.v .+ (1 - p.β_2) * grad .^ 2

    m_hat = m / (1 - p.β_1 ^ t)
    v_hat = v / (1 - p.β_2 ^ t)

    Δ = - p.α * m_hat ./ (.√(v_hat) .+ p.ε)

    new_state = AdamState(t, m, v)

    return (Δ, new_state)
  end
  (init, adabelief)
end

struct MomentumParameter
  ϵ::Float64
  β::Float64
end

struct MomentumState
  t::Int64
  m::Union{Float64,Array{Float64}}
end

function new_momentum(p::MomentumParameter)
  init = MomentumState(0, 0.)
  function momentum(state::MomentumState, grad::Array{Float64})::Tuple{Array{Float64}, MomentumState}
    t = state.t + 1
    m = p.β * state.m .+ (1 - p.β) * grad

    new_state = MomentumState(t, m)

    Δ = - p.ϵ * m

    return (Δ, new_state)
  end
  (init, momentum)
end