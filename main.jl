using Nemo
using ProgressMeter

function main()
    p = 5   # prime
    d = 2   # degree
    N = p^d-1   # the number of invertible elements
    F, a = FiniteField(p, d, "a")
    
    # the def. polynomial
    surf(x, y, z, w) = 1 + x + y + z + w + F(1)//(x*y*z*w)

    # for all invertible elements
    count = 0
    M = N^4
    p = Progress(M, 1)
    for i = 1:N, j = 1:N, k = 1:N, l = 1:N
        #println("$(a^i): $(surf(a^i))")
        x = a^i
        y = a^j
        z = a^k
        w = a^l
        count += ifelse(surf(x, y, z, w) == 0, 1, 0)    # ?function-call overhead?       
        next!(p)
    end
    println("Count: $count")
end

@time main()
