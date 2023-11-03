dict = {}
#names=[]
names_of_samples_to_join=[]
names_of_samples_not_to_join=[]
with open('list_batch2.txt','r') as f:
    lines = f.readlines()
    for line in lines:
        tempName = "_".join(line.split("_")[:2])
        if tempName not in dict:
            dict[tempName]=1
        else: 
            dict[tempName]+=1
    print(dict)


for key in dict:
    if dict[key] > 2:
        with open('samplesThatNeedCat_batch2_samplenames.txt', 'a') as f:
            f.write(key+"\n")
        with open('list_batch2.txt','r') as f:
            lines = f.readlines()
            for line in lines:
                if key in line:
                    names_of_samples_to_join.append(line)
    """
    else:
        with open('samplesThatNeedCat2.txt', 'a') as f:
            f.write(key+"\n")
        with open('list_genomes.txt','r') as f:
            lines = f.readlines()
            for line in lines:
                if key in line:
                    names_of_samples_not_to_join.append(line)
     """   
"""
for key in dict:
    if dict[key] > 2:
        names.append(key)
print (names)

with open('list_genomes.txt','r') as f:
    lines = f.readlines()
    for line in lines:
        for name in names:
            if name in line:
                names_of_samples.append(line)
"""
print(names_of_samples_to_join)
with open('samplesThatNeedCat_batch2.txt', 'w') as f:
    for name in names_of_samples_to_join:
        f.write(name)
        
        
