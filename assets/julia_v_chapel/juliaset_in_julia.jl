using PyPlot

# julia set
# (the familiar mandelbrot set is obtained by setting c==z initially)
function julia(z, c; maxiter=200)
    for n = 1:maxiter
        if abs2(z) > 4
            return n-1
        end
        z = z*z + c
    end
    return maxiter
end

juliaset = [ UInt8(julia(complex(r,i), complex(-.06,.67))) for i=1:-.002:-1, r=-1.5:.002:1.5 ];

get_cmap("RdGy")

imshow(m, cmap="RdGy", extent=[-1.5,1.5,-1,1])
