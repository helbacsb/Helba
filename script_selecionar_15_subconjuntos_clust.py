"""
Title: clust.py
Author: Guilherme Yudi Aiabe Sagawa (GYAS)
Date: March 19th, 2024

Description: This code performs a clustering filtering, individualizing them into sets \\
determined by the cultivars contained within each one.

(!!!) Usage: In the function main(), you need to insert the path of input file and a directory for output files

(!!!) Take a look in the metadata.tsv file

"""

import time
import os
from pathlib import Path
from itertools import product

def get_clusters(input_file, output_dir):
    cultivar = ['SP80-3280', 'IAC66-6', 'CB49-260', 'SP78-4467'] # List of cultivar (names)
    cluster = [] # Set of clusters
    representative = [] # Set of representative contigs of each cluster
    position = [] # Position (line) of each cluster header
    table = [] # A binary table that sets the cultivar of each cluter
    lines = [] # Processed file input
    out = {} # A Dictionary of the cluster per cultivar

    ### Raw data reading ###
    with open(input_file, 'r') as input:
        lines = input.readlines()
        for i, line in enumerate(lines):
            if line.startswith('>'):
                cluster.append(line.strip().split('>')[1]) # Set cluster
                position.append(i) # Set Position
            if '*' in line:
                representative.append(line.strip().split('>')[1]) # take the representative contig of the cluster
    

    spp = [0, 0, 0, 0] # Default list to determines which cultivar is  in the cluster [0 to absent and 1 to presence]
    for i in range(len(position)-1):
        for j, var in enumerate(cultivar):
            control = False
            if control:
                break
            for item in lines[position[i]+1:position[i+1]]:
                if var in item:
                    spp[j] = 1
                    control = True
                    break
        table.append(spp)
        spp = [0, 0, 0, 0] # Refresh the list

    ### Only in the case of the last cluster ###
    control = False
    for j, var in enumerate(cultivar):
        if control:
            break
        for item in lines[len(position):]:
            if var in item:
                spp[j] = 1
                control = True
                break
        table.append(spp)

    # Define the values of each position
    values = [0, 1]
    # Generate all of combination in a cartesian product
    all_combinations = list(product(values, repeat=4))
    for combination in all_combinations:
        out[combination] = []
        for i, item in enumerate(table):
            if item == list(combination):
                out[combination].append(i)

    dir_out = Path(f'{output_dir}/output')
    if not dir_out.exists():
        os.mkdir(dir_out)
    for k, key in enumerate(out.keys()):
        if key == (0, 0, 0, 0):
            continue
        else:
            name = f'set_{k}'
            with open(f'{dir_out}/GYAS_{name}.tsv', 'w') as output:
                for i in out[key]:
                    output.write(f'{cluster[i]}\t{representative[i]}\n')

    with open(f'{dir_out}/GYAS_metadata.tsv', 'w') as metadata:
        metadata.write('Set\tSP80-3280\tIAC66-6\tCB49-260\tSP78-4467\tcount\n')
        for k, key in enumerate(out.keys()):
            if key == (0, 0, 0, 0):
                continue
            else:
                name = f'set_{k}'
                metadata.write(f'{name}')
                for index, item in enumerate(key):
                    if item == 1:
                        metadata.write(f'\t+')
                        #metadata.write(f'\t{cultivar[index]}')
                    else:
                        metadata.write('\t-')
                metadata.write(f'\t{len(out[key])}\n')
        metadata.write('\n- means absent in the set\n+ means present in the set\ncount = number of clusters in the set')

def main():
    input_file = '' # Insert here your input's path
    output_dir = '' # 
    start = time.time() # Start point
    get_clusters(input_file, output_dir)
    end = time.time() # end point 
    delta = (end - start)/60
    print(f'{delta} minutes of execution')

if __name__ == '__main__':
    main()