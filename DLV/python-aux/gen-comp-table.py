# Output facts corresponding to the RCC-5 composition table (5x5 entries)

d = 16                      # dr (disjoint region)
e = 8                       # eq (equals)
i = 4                       # ppi (proper part inverse)
o = 2                       # po (partial overlap)
p = 1                       # pp (proper part)


# b5 = { 'p':1, 'o':2, 'i':4, 'e':8, 'd':16 } 
# b5i = { 1:'p', 2:'o', 4:'i', 8:'e', 16:'d' } 

# RCC5 composition table
CT = { d: { d: {d,o,e,i,p},
            o: {d,o,p},
            e: {d},
            i: {d},
            p: {d,o,p} },
       o: { d: {d,o,i},
            o: {d,o,e,i,p},
            e: {o},
            i: {d,o,i},
            p: {o,p} },
       e: { d: {d},
            o: {o},
            e: {e},
            i: {i},
            p: {p} },
       p: { d: {d},
            o: {d,o,p},
            e: {p},
            i: {d,o,e,i,p},
            p: {p} },
       i: { d: {d,o,i},
            o: {o,i},
            e: {i},
            i: {i},
            p: {o,e,p,i} }
    }



def main():
# for r1 in CT:
#     for r2 in CT:
#         print r1, r2, CT[r1][r2]
#         print b5i[r1], b5i[r2], [ b5i[x] for x in CT[r1][r2] ]

    CTC = {}
        
    for r1 in CT:
        CTC[r1] = {} 
        for r2 in CT:
            CTC[r1][r2] = {d,o,e,i,p} - CT[r1][r2]
            print "ct({0},{1},{2}).".format(r1,r2, sum(CT[r1][r2]) )
            print "cc({0},{1},{2}).".format(r1,r2, sum(CTC[r1][r2]) )


if __name__ == '__main__':
    main()
