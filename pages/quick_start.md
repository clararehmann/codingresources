
# Talapas (very) quick start guide
##### Compiled from [the UO Talapas documentation](https://hpcrcf.atlassian.net/wiki/spaces/TCP/). Login and file transfer instructions are for a Linux or Mac OS X system. If you are working with a Windows system, check out the [Windows subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/faq) or an SSH client like Putty or MobaXterm.

## 1. Shelling in

Open Terminal. The following command will use the [SSH protocol](https://en.wikipedia.org/wiki/Secure_Shell_Protocol) to connect your terminal to Talapas, after prompting you for your password.

	ssh <myDuckID>@talapas-ln1.uoregon.edu


#### 1.5 Transferring files to and from Talapas

To move files to Talapas from your local machine, open a local terminal and type:

	scp -r path/to/file_local <myDuckID>@talapas-ln1.uoregon.edu:./path/to/file_tp

To move files from Talapas to your local machine, open a local terminal and type:

	rsync -auv <myDuckID>@talapas-ln1.uoregon.edu:./path/to/file_tp path/to/file_local

## 2. Using software

On Talapas, software packages are stored in modules using the [Lmod environment](https://lmod.readthedocs.io/en/latest/). 

To see currently loaded modules:

	module list

To see currently available modules:

	module avail

To search for a module (eg, `blast`):

	module spider blast

Loading an available module allows you to use its commands:

	module load <modulename>

And you can unload a module if it's unnecessary or conflicts with something:

	module unload <modulename>

## 3. Running a job

Talapas allows you to submit **batch jobs** (directions for running code) to the **cluster**, which sends the job to **nodes** (computers that will run your code). The [SLURM job scheduler](https://slurm.schedmd.com/) is used to partition what jobs run when on which nodes. 

To submit jobs to be run on the cluster, use a batch script, which specifies the resources needed to run the job and the actual code used to execute the job (an in-depth example can be found at `scripts/job.batch`; the following is a basic example):

##### example_job.batch

	#!/bin/bash

	#SBATCH --account=<account>
	#SBATCH --partition=<partition>
	#SBATCH --job-name=example
	#SBATCH --output=example.out
	#SBATCH --error=example.err
	
	code to execute

To enter the job into the SLURM queue, use:

	sbatch example_job.batch

Once your job is submitted, it will be managed by SLURM - that means you can log out of Talapas, use your terminal for other things, or even shut down your local machine without interrupting your code.

After you submit a job, it will be given a job ID, which you can use to check in on it.

	$ sbatch example_job.batch
	Submitted batch job 00000
	
	# check the job's position in the queue
	$ squeue -j 00000
		JOBID  PARTITION  NAME    USER  ST  TIME  NODES  NODELIST(REASON)
		00000     short  example  user   R   5:08     1   n003
