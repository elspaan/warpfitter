#!/bin/bash

pwd; hostname; date

# === Config ===
N0=0 # start
Nf=10 # number of step batch segments
W=250 # number of walkers, should agree with log pars name
S=1000 # segments of steps
disk="diskv2" # disk name as per the outtag in fit_mc_<disk>_warped.py; v2 is to separate it from the OG exoALMA set
tag_out="${disk}_12co_exoALMA_nstepsperiter${S}_restartbackend"

# seq is unix shell command for generating a sequence of numbers running from $start to $stop
for i in $(seq $N0 $Nf); do
    echo "===== Submitting iteration $i ====="
    tsteps=$(( S * i ))
    filename="backend_${tag_out}.h5"

    if [ -f "$filename" ]; then
        echo ">>> Found backend: $filename"
        bflag=0
        logpars="log_pars_${tag_out}_cube_${W}walkers_${S}steps.txt"
        # logpars="log_pars_${tag_out}_cube_${W}walkers_${S}steps.json"
    else
        echo ">>> No backend found"
        bflag=0
        logpars="log_pars_${disk}_12co_exoALMA_cube_${W}walkers_0steps.txt"
        #logpars="log_pars_${disk}_12co_exoALMA_cube_${W}walkers_0steps.json"
    fi

    # Run PREP and wait for it to finish (bash does this automatically)
    echo ">>> Running PREP for iteration $i..."
    bash run_prep_only.sh $i $W $S $bflag $logpars $tag_out
    echo ">>> PREP done."

    # Run FIT and wait for it to finish
    echo ">>> Running FIT for iteration $i..."
    bash run_fit_only.sh $i $W $S $bflag $tag_out
    echo ">>> FIT done."

    cp mc_walkers_${tag_out}_${W}walkers_${S}steps.png \
       mc_walkers_${tag_out}_${W}walkers_${tsteps}steps_bflag${bflag}.png

done

echo "All iterations submitted and completed sequentially."

date
