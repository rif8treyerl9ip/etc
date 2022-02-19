from asyncio import subprocess


import subprocess

a = subprocess.check_output(["ls"])
print(a)
print(a.decode())

print('######################################################')

a = subprocess.run(["ls"],stdout=subprocess.PIPE)
print(a.stdout.decode())

print('######################################################')
a = subprocess.getoutput(["ls"])
print(a)