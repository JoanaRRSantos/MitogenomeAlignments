file1 = open('colocarGaps.txt', 'r')
Lines = file1.readlines()
tempSeq=""
results=[]
for line in range(len(Lines)-2):
    if "-" in Lines[line]:
        tempPos=int(Lines[line].split("-")[-1])
        for i in range(tempPos):
            tempSeq = tempSeq + "-"
        tempSeq = tempSeq + Lines[line+2]
        results.append(Lines[line+1])
        results.append(tempSeq)
        tempSeq=""
print(results)
for i in results:
    with open("genesCOMgaps.txt", "a") as f:
        f.write(i)

    