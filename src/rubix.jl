struct rubix
    config::Permutation
end

rubix() = Permutation(27)

#order is reversed because when reading algorithms, you read from left to right.
Base.:*(x::rubix,y::rubix) = rubix(y.config * x.config)

#a rubix cube corners are odd numbers
#edges are even numbers
#8 corners and 12 edges, so 20 in total

#=
If you imagine the cube's corners are at (±1,±1,±1),
the edges are tuples with a 0, and corners are all ±1s.
Then we could give each vertex a number using ternary representation
-1=>0,0=>1,1=>2

so the smallest number is (-1,-1,-1)=>0. Since permutations starts at
1, we add the result by 1.
The largest is (1,1,1)=>27

So the formula for conversion is
(a,b,c)=>9(a+1)+3(b+1)+(c+1)+1 = 9a+3b+c+14
=#
label(x::Tuple{Int64,Int64,Int64}) = 9x[1]+3x[2]+x[3]+14


#=
We are viewing the rubix cube from the negative y axis, or imagine
standing at (0,-10,0) and looking at (0,0,0)

Right,Up,Front,Down,Left,Back
=#

R = rubix(Permutation([1:18 ...,21,24,27,20,23,26,19,22,25]))
U = rubix(Permutation([1,2,9,4,5,18,7,8,27,10,11,6,13:17 ...,24,19,20,3,22,23,12,25,26,21]))
F = rubix(Permutation([3,12,21,4:9 ...,2,11,20,13:18 ...,1,10,19,22:27 ...]))
D = rubix(Permutation([7,2,3,16,5,6,25,8,9,4,11:15 ...,22,17,18,1,20,21,10,23,24,19,26,27]))
L = rubix(Permutation([7,4,1,16,5,2,9,8,3,10:15 ...,6,17:27 ...]))
B = rubix(Permutation([1:6 ...,25,16,7,10:15 ...,26,17,8,19:24 ...,27,18,9]))
Base.inv(x::rubix)=rubix(x.config')
Base.adjoint(x::rubix)=inv(x)

function Base.show(io::IO, p::rubix)
    for i in cycles(p.config)
        length(i)!=1 && print(io,Permutations.array2string(i))
    end
end
