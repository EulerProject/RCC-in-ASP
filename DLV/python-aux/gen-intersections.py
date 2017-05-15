# generate all pairs of mutually exclusive RCC5 relations

r32 = list(range(32))

for i in r32:
    for j in r32:
        print "i({0},{1}, {2}).".format(i,j, i&j)
