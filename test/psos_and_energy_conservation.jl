using OrdinaryDiffEq, DiffEqCallbacks
using Base.Test

@testset "PSOS and Energy Conservation" begin 
    # Initial state
    u0=[0, -0.25, 0.42081, 0]

    function hheom!(t, u::AbstractVector, du::AbstractVector)
        du[1] = u[3]
        du[2] = u[4]
        du[3] = -u[1] - 2u[1]*u[2]
        du[4] = -u[2] - (u[1]^2 - u[2]^2)
        return nothing
    end

    @inline Vhh(q1, q2) = 1//2 * (q1^2 + q2^2 + 2q1^2 * q2 - 2//3 * q2^3)
    @inline Thh(p1, p2) = 1//2 * (p1^2 + p2^2)
    @inline Hhh(q1, q2, p1, p2) = Thh(p1, p2) + Vhh(q1, q2)
    @inline Hhh(u::AbstractVector) = Hhh(u...)

    # Energy
    const E = Hhh(u0)

    function ghh(u, resid)
        resid[1] = Hhh(u[1],u[2],u[3],u[4]) - E
        resid[2:4] .= 0
    end

    # energy conserving callback:
    # important to use save = false, I dont want rescaling points
    cb = ManifoldProjection(ghh, nlopts=Dict(:ftol=>1e-13), save = false)

    # Callback for Poincare surface of section
    function psos_callback(j, direction = +1, offset::Real = 0,
        callback_kwargs = Dict{Symbol, Any}(:abstol=>1e-9))

        # Prepare callback:
        s = sign(direction)
        cond = (t,u,integrator) -> s*(u - offset)
        affect! = (integrator) -> nothing

        cb = DiffEqBase.ContinuousCallback(cond, affect!, nothing; callback_kwargs...,
        save_positions = (true,false), idxs = j)
    end

    # with this callback, the saved values of variable 1 should be zero
    poincarecb = psos_callback(1)

    totalcb = CallbackSet(poincarecb, cb)

    prob = ODEProblem(hheom!, u0, (0.0, 100.0), callback = totalcb)

    extra_kw = Dict(:save_start=>false, :save_end=>false)
    DEFAULT_DIFFEQ_KWARGS = Dict{Symbol, Any}(:abstol => 1e-9, :reltol => 1e-9)

    sol = solve(prob, Vern9(); extra_kw..., DEFAULT_DIFFEQ_KWARGS..., save_everystep = false)

    Es = [Hhh(sol[:, i]) for i in 1:length(sol)]
    Eerror = maximum(@. abs(E - Es))
           
    a = sol[1, :]
    
    @test Eerror < 1e-10
    for el in a
        @test abs(el) < 1e-10
    end

end

