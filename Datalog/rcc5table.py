

'''This file generates a set of compose(r1,r2,r3) facts where r1 is a
   relation in RCC5 between nodes x and y, r2 is a relation in RCC5
   between nodes y and z, and r3 is the (inferred) relation between x
   and z (based on the rcc5 composition table).

   To run, use: 
      python rcc5table
'''
 

dr = 'dr'                       # disjoint region
po = 'po'                       # partial overlap
eq = 'eq'                       # equal region
pp = 'pp'                       # proper part
pi = 'pi'                       # proper part inverse


table = {dr: {dr: {dr,po,eq,pi,pp},
              po: {dr,po,pp},
              eq: {dr},
              pi: {dr},
              pp: {dr,po,pp}},
         po: {dr: {dr,po,pi},
              po: {dr,po,eq,pi,pp},
              eq: {po},
              pi: {dr,po,pi},
              pp: {po,pp}},
         eq: {dr: {dr},
              po: {po},
              eq: {eq},
              pi: {pi},
              pp: {pp}},
         pp: {dr: {dr},
              po: {dr,po,pp},
              eq: {pp},
              pi: {dr,po,eq,pi,pp},
              pp: {pp}},
         pi: {dr: {dr,po,pi},
              po: {po,pi},
              eq: {pi},
              pi: {pi},
              pp: {po,eq,pp,pi}}}


def infer_rels(xy_rels, yz_rels):
    Mxy = set()
    for xy_rel in xy_rels:
        for yz_rel in yz_rels:
            Mxy = Mxy.union(table[xy_rel][yz_rel])
    return Mxy


def inv(rels):
    inv_rels = set()
    for rel in rels:
        if rel == pp:
            inv_rels.add(pi)
        elif rel == pi:
            inv_rels.add(pp)
        else:
            inv_rels.add(rel)
    return inv_rels


def find_rel(i, j, given_rels):
    for (i0, j0, rel) in given_rels:
        if i == i0 and j == j0:
            return rel
        elif i == j0 and j == i0:
            return inv(rel)
    return {dr,eq,po,pp,pi}
                    

# input:
#     list of rels [(i,j,rels), ...]
#     number of nodes n
def path_consistent(given_rels, n):
    # create an nxn matrix
    matrix = [[{} for j in range(n)] for i in range(n)]
    for i in range(n):
        for j in range(n):
            if i != j:
                matrix[i][j] = find_rel(i, j, given_rels)
    # queue of rels to infer
    queue = []
    for i in range(n):
        for j in range(n):
            for k in range(n):
                if i != j and j != k and i != k:
                    queue.append((i,j,k))
    # calculate new rels until we reach a fixpoint
    while queue != []:
        i, k, j = queue.pop()
        oldM = matrix[i][j]
        Mij = infer_rels(matrix[i][k], matrix[k][j])
        Mij = oldM.intersection(Mij)
        if Mij == set():
            return False
        if oldM != Mij:
            matrix[i][j] = Mij
            matrix[j][i] = inv(Mij)
            queue.append((i, k, j))

    return matrix


def as_str(rels):
    rels = list(rels)
    rels.sort()
    s = ''
    for r in rels:
        s += r
    return s


def main():
    # R32 (minus empty)
    rcc5 = [{pp}, {po}, {po,pp}, {pi},
            {pi,pp}, {pi,po}, {pi,po,pp}, {eq},
            {eq,pp}, {eq,po}, {eq,po,pp}, {eq,pi},
            {eq,pi,pp}, {eq,pi,po}, {eq,pi,po,pp}, {dr},
            {dr,pp}, {dr,po}, {dr,po,pp}, {dr,pi},
            {dr,pi,pp}, {dr,pi,po}, {dr,pi,po,pp}, {dr,eq},
            {dr,eq,pp}, {dr,eq,po}, {dr,eq,po,pp}, {dr,eq,pi},
            {dr,eq,pi,pp}, {dr,eq,pi,po}, {dr,eq,pi,po,pp}]
    n = len(rcc5)
    for i in range(n):
        for j in range(n):
            given_rels = [(0,1,rcc5[i]),(1,2,rcc5[j])]
            matrix = path_consistent(given_rels, 3)
            r1 = as_str(matrix[0][1])
            r2 = as_str(matrix[1][2])
            r3 = as_str(matrix[0][2])
            print 'compose(' + r1 + ',' + r2 + ',' + r3 + ').'
                 

if __name__ == '__main__':
    main()
