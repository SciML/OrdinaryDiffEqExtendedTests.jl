using OrdinaryDiffEq,DiffEqProblemLibrary, DiffEqDevTools, Base.Test, ODEInterfaceDiffEq

prob = prob_ode_linear
sol = solve(prob,DP5())

sol2 = solve(prob,dopri5())
@test sol.t[2] ≈ sol2.t[2]

prob = prob_ode_2Dlinear
sol = solve(prob,DP5(),internalnorm=(u)->sqrt(sum(abs2,u)))

# Change the norm due to error in dopri5.f
sol2 = solve(prob,dopri5())
@test sol.t[2] ≈ sol2.t[2]

prob = deepcopy(prob_ode_linear)
prob.tspan = (1.0,0.0)
sol = solve(prob,DP5())

sol2 = solve(prob,dopri5())
@test sol.t[2] ≈ sol2.t[2]

prob = deepcopy(prob_ode_2Dlinear)
prob.tspan = (1.0,0.0)
sol = solve(prob,DP5(),internalnorm=(u)->sqrt(sum(abs2,u)))

# Change the norm due to error in dopri5.f
sol2 = solve(prob,dopri5())
@test sol.t[2] ≈ sol2.t[2]
