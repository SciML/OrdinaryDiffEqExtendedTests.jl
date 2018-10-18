using StaticArrays
using Parameters
using OrdinaryDiffEq

@inbounds @inline function ż(z, p, t)
    @unpack A, B, D = p
    p₀, p₂ = z[1:2]
    q₀, q₂ = z[3:4]

    return SVector{4}(
        -A * q₀ - 3 * B / √2 * (q₂^2 - q₀^2) - D * q₀ * (q₀^2 + q₂^2),
        -q₂ * (A + 3 * √2 * B * q₀ + D * (q₀^2 + q₂^2)),
        A * p₀,
        A * p₂
  )
end

condition(u, t, integrator) = u
affect!(integrator) = nothing
cb(idx) = ContinuousCallback(condition,
    affect!, nothing, save_positions=(false, true), idxs=idx)
z0 = SVector{4}(7.1989885061904335, -0.165912283356219, 0., -3.63534900748947)

tspan=(0.,300.)
prob=ODEProblem(ż, z0, tspan, (A=1, B=0.55, D=0.4), callback=cb(3))
sol=solve(prob, Vern9(), abstol=1e-14, reltol=1e-14,
    save_everystep=false, save_start=false, save_end=false, maxiters=1e6)

length(sol) == 126

prob=ODEProblem(ż, z0, (0,400.), (A=1, B=0.55, D=0.4), callback=cb(3))
sol=solve(prob, Vern9(), abstol=1e-14, reltol=1e-14, save_everystep=false, save_start=false, save_end=false, maxiters=2e4)
