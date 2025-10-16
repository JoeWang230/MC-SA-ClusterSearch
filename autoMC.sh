#!/bin/bash
file="my.sites.temp"

# Total number of sites
nsites=$(awk '/sites$/ {print $1; exit}' "$file")

# Line number of "Values"
values_line=$(grep -n "Values" "$file" | cut -d: -f1)

# Extract header including "Values"
head -n "$values_line" "$file" > header.txt

for n2 in {1..10}; do
  for n3 in {1..10}; do
    dirname="n2_${n2}_n3_${n3}"

    # Check if directory already exists
    if [ -d "$dirname" ]; then
	    echo "Skipping $dirname (already exists)"
	    continue
    fi

    mkdir -p "$dirname"
    outfile="${dirname}/my.sites.modified"

    # Randomly select IDs
    shuf -i 1-$nsites -n $((n2+n3)) > random_ids.txt
    head -n $n2 random_ids.txt > ids2.txt
    tail -n $n3 random_ids.txt > ids3.txt

    # Write header first
    cat header.txt > "$outfile"

    # Modify only the site data lines
    tail -n +"$((values_line + 1))" "$file" | awk -v ids2_file="ids2.txt" -v ids3_file="ids3.txt" '
      BEGIN{
        while((getline line < ids2_file) > 0) ids2[line]=1
        while((getline line < ids3_file) > 0) ids3[line]=1
      }
      {
        id=$1
        if(id in ids2) $2=2
        else if(id in ids3) $2=3
        print
      }
    ' >> "$outfile"

    echo "Created $outfile"
    
    # Copy necessary files for SA-MC simulation to current subdirectory
    cp ./spk_openmpi ./in.diffCE ./paramsCEAlMgSiv16 $dirname

    # Run simulation in the current subdirectory
    cd "$dirname"
    echo "Running SA-MC in directory: $dirname"
    mpirun -np 1 ./spk_openmpi < in.diffCEAlMgSi
    cd - > /dev/null

  done
done

rm -f random_ids.txt ids2.txt ids3.txt header.txt
