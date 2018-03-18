using Nemo
using ProgressMeter

function main()
    p = 5   # prime
    d = 3   # degree
    N = p^d-1   # the number of invertible elements
    F, a = FiniteField(p, d, "a")

    # the def. polynomial
    surf(x, y, z, w) = 1 + x + y + z + w + F(1)//(x*y*z*w)

    # for all invertible elements
    count = 0
    # comb.type (1, 1, 1, 1)
    count1 = 0
    @showprogress for i = 1:N, j = (i+1):N, k = (j+1):N, l = (k+1):N
        #println("$(a^i): $(surf(a^i))")
        comb = 24   # 4!
        x = a^i
        y = a^j
        z = a^k
        w = a^l
        count1 += ifelse(surf(x, y, z, w) == 0, comb, 0)    # ?function-call overhead?

        #next!(p)
    end
    println("(1, 1, 1, 1): $count1")

    # comb.type (2, 1, 1)
    lst = [(i, j, k) for i = 1:N for j = 1:N for k = 1:(j-1) if i!=j && i!=k]
    count2 = 0
    @showprogress for (i, j, k) in lst
        #println("$(a^i): $(surf(a^i))")
        comb = 12   # 4C2 * 2!
        x = a^i
        y = a^j
        z = a^k
        count2 += ifelse(surf(x, x, y, z) == 0, comb, 0)    # ?function-call overhead?
    end
    println("(2, 1, 1): $count2")

    # comb.type (2, 2)
    count3 = 0
    @showprogress for i = 1:N, j = 1:(i-1)
        #println("$(a^i): $(surf(a^i))")
        comb = 6   # 4C2 
        x = a^i
        y = a^j
        count3 += ifelse(surf(x, x, y, y) == 0, comb, 0)    # ?function-call overhead?
    end
    println("(2, 2): $count3")

    # comb.type (3, 1)
    lst = [(i, j) for i = 1:N for j = 1:N if i!=j]
    count4 = 0
    @showprogress for (i, j) in lst
        #println("$(a^i): $(surf(a^i))")
        comb = 4   # 4C3
        x = a^i
        y = a^j
        count4 += ifelse(surf(x, x, x, y) == 0, comb, 0)    # ?function-call overhead?
    end
    println("(3, 1): $count4")

    # comb.type (4)
    count5 = 0
    @showprogress for i = 1:N
        #println("$(a^i): $(surf(a^i))")
        comb = 1   # 4C4
        x = a^i
        count5 += ifelse(surf(x, x, x, x) == 0, comb, 0)    # ?function-call overhead?
    end
    println("(4): $count5")

    count = count1 + count2 + count3 + count4 + count5
    println("Count: $count")
end

@time main()
