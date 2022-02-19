import subprocess

print('subprocess Start')
a = subprocess.run(["Python3","calc.py"])
print('subprocess End')

print('subprocess Start')
a = subprocess.Popen(["Python3","calc.py"])
print('subprocess End')

