from scipy.optimize import linprog
c=[70,80,85]
A_ub=[[1,4,8],[40,30,20],[3,2,4]]
b_ub=[4500,36000,2700]
A_eq=[[1,1,1]]
b_eq=[999]

res=linprog(c,A_ub,b_ub,A_eq,b_eq,bounds=(0,None))
print(res)
print("Valor Optimo: ",res.fun,"\nX: ", res.x)


print("Segundo Ejercicio")
c=[430,460,420]
A_ub=[[-1,-3,-1],[-2,0,-4],[-1,-2,0]]
b_ub=[-3,-2,-5]
res2=linprog(c,A_ub,b_ub,bounds=(0,None))
print(res2)
print("Valor Optimo: ",res2.fun,"\nX: ", res2.x)
