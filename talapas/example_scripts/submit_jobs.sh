# an example of using a shell script to submit batch jobs

#!/bin/bash

for run in run_0 run_1 run_2 run_3 run_4; do  # for each run,
    sbatch job.batch $run                     # submit a batch job with that parameter specified
done
