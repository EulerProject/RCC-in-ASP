# generate all pairs of mutually exclusive RCC5 relations

base5xy = ['eq(X,Y)', 'dr(X,Y)', 'pp(X,Y)', 'pi(X,Y)', 'po(X,Y)']
base5yz = ['eq(Y,Z)', 'dr(Y,Z)', 'pp(Y,Z)', 'pi(Y,Z)', 'po(Y,Z)']

N = len(base5xy)

for i in range(N):
    for j in range(N):
        print "eq(X,Z) v dr(X,Z) v pp(X,Z) v pi(X,Z) v po(X,Z) :- {0}, {1}.".format(base5xy[i],base5yz[j])

