#!/bin/bash
# ===============================================
# Script: extract_energies.sh
# Purpose: Extract energy from log.spparks files
#          (last-16th row) in each existing dir.
#          Output format: n2   n3   energy
# ===============================================

outfile="energies.dat"
: > "$outfile"   # clear the file

# Loop over all existing n2_*_n3_* directories
for dir in n2_*_n3_*; do
  logfile="$dir/log.spparks"

  if [[ -f "$logfile" ]]; then
    # Extract n2 and n3 from directory name
    n2=$(echo "$dir" | sed -E 's/n2_([0-9]+)_n3_([0-9]+)/\1/')
    n3=$(echo "$dir" | sed -E 's/n2_([0-9]+)_n3_([0-9]+)/\2/')

    # Find last-16th line and get last column (energy)
    total_lines=$(wc -l < "$logfile")
    target_line=$((total_lines - 15))
    energy=$(awk -v n=$target_line 'NR==n {print $NF}' "$logfile")

    echo "$n2   $n3   $energy" >> "$outfile"
    echo "Extracted: n2=$n2, n3=$n3 → $energy"
  else
    echo "Skipping $dir (no log.spparks found)"
  fi
done

echo "✅ Energies collected in $outfile"

