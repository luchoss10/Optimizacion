import numpy
from cvxopt import matrix, solvers
import matplotlib.pyplot as plt

#A=cvxopt.matrix([-1,-2,1,0,-1.5,-1,0,1],(4,2))
c=matrix([50., 40.])
A=matrix([[-1., -2., 1., 0.], [-1.5, -1., 0., 1.]])
b=matrix([750., 1000., 0., 0.])
sol= solvers.lp(c, A, b)
print(sol['x'][0]*-1,sol['x'][1]*-1)

# Resolviendo la optimizacion graficamente.

x_vals = numpy.linspace(0, 800, 10) # 10 valores entre 0 y 800
y1 = ((750 - x_vals)/1.5) # x1 + 1.5x2 = 750
y2 = (1000 - 2*x_vals) # 2x1 + x2 = 1000
plt.figure(figsize=(10,8))
plt.plot(x_vals, y1, label=r'$x_1 + 1.5x_2 \leq 750$') 
plt.plot(x_vals, y2, label=r'$2x_1 + x_2 \leq 1000$') #
plt.plot(375, 250, 'b*', markersize=15)

# Región factible
y3 = numpy.linspace.minimum(y1, y2)
plt.fill_between(x_vals, 0, y3, alpha=0.15, color='b')
plt.axis(ymin = 0)
plt.title('Optimización lineal')
plt.legend()
plt.show()