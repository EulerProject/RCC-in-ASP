

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


# each row [r1,r2,r] describes a case where B r1 D, C r2 D, and A r D,
# where A is covered by B and C.
table = [[dr,dr,{dr}],
         [dr,eq,{pi}],
         [dr,po,{po}],
         [dr,pp,{po}],
         [dr,pi,{pi}],
         [po,po,{po,pi}],
         [po,pp,{po,pi}],
         [pp,pp,{eq,pp}]]
                   

def bottom_up_inf(r1,r2):
    r = set()
    for row in table:
        if row[0] in r1 and row[1] in r2:
            r.update(row[2])
    return r


def top_down_inf(r, r1):
    r2 = set()
    for row in table:
        if len(row[2].intersection(r)) > 0:
            if row[0] in r1:
                r2.add(row[1])
            if row[1] in r1:
                r2.add(row[0])
    return r2


def as_str(rels):
    list_rels = list(rels)
    list_rels.sort()
    s = ''
    for r in list_rels:
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
    # bottom up cases
    rules = set()
    for i in range(n):
        for j in range(n):
            r1 = rcc5[i]
            r2 = rcc5[j]
            r = bottom_up_inf(r1, r2)
            t1 = 'r('+as_str(r1)+',B,D)'
            t2 = 'r('+as_str(r2)+',C,D)'
            t3 = 'r('+as_str(r)+',A,D)'
            if len(r) > 0:
                rules.add(t3 + ' :- ' + 'tt(A,B,C), ' + t1 + ', ' + t2 + '.')
    print '% bottom-up coverage rules'
    rules = list(rules)
    rules.sort()
    for rule in rules:
        print rule
    # top down cases
    rules = set()
    for i in range(n):
        for j in range(n):
            r = rcc5[i]
            r1 = rcc5[j]
            r2 = top_down_inf(r, r1)
            t1 = 'r('+as_str(r)+',A,D)'
            t2 = 'r('+as_str(r1)+',B,D)'
            t3 = 'r('+as_str(r2)+',C,D)'
            if len(r2) > 0:
                rules.add(t3 + ' :- ' + 'tt(A,B,C), ' + t1 + ', ' + t2 + '.')
    print '% top-down coverage rules'
    rules = list(rules)
    rules.sort()
    for rule in rules:
        print rule


if __name__ == '__main__':
    main()
