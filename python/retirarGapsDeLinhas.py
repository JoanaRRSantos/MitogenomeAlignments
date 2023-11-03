file1 = open('seq_ref_dora.fas', 'r')
Lines = file1.readlines()
with open('seq_ref_dora_sem_gaps.txt', 'a') as f:
    for line in range(len(Lines)):
        if "-" in Lines[line]:
            newLine = Lines[line].replace("-", "")
            f.write(newLine)
        else:
            f.write(Lines[line])