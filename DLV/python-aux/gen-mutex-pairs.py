# generate all pairs of mutually exclusive RCC5 relations

base5 = ['eq(X,Y)', 'dr(X,Y)', 'pp(X,Y)', 'pi(X,Y)', 'po(X,Y)']

N = len(base5)

for i in range(N):
    for j in range(i+1,N):
        print ":- {0}, {1}.".format(base5[i],base5[j])

