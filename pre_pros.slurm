#!/bin/bash
#SBATCH --job-name=mission
#SBATCH --output=output_%j.log      # Output file (%j for job ID)
#SBATCH --account=module-mlp
#SBATCH --error=error_%j.log        # Error file
#SBATCH --time=4-00:00:00                   # Max runtime (HH:MM:SS)
#SBATCH --partition=PGR-Standard                # Partition (use appropriate partition)
#SBATCH --ntasks-per-node=8                      # Number of tasks (adjust as needed)
#SBATCH --gres=gpu:8
#SBATCH --cpus-per-task=2

# Print job details
echo "SLURM Job ID: $SLURM_JOB_ID"
echo "Node List: $SLURM_NODELIST"
echo "Tasks per Node: $SLURM_NTASKS_PER_NODE"
echo "Total Tasks: $SLURM_NTASKS"
echo "CPUs per Task: $SLURM_CPUS_PER_TASK"
echo "GPUs per Task: $SLURM_GPUS_ON_NODE"


# Run the Python script
#srun python meshgpt-pytorch/train_autoencoder.py
source ~/mlp/bin/activate
# srun accelerate launch --multi-gpu train_auto.py
srun accelerate launch --multi-gpu data/tag.py ./babylm_data/train_100M/open_subtitles.train
# srun accelerate launch --multi-gpu continue_auto.py

