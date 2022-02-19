def mygenerator(stop,start=0):
    current_value = start
    while True:
        if current_value > stop:
            break

        yield current_value
        current_value+=1

def main():
    gene = mygenerator(10)
    for i in gene:
        print(i,end=' ')

if __name__ == '__main__':
    main()

    
    
