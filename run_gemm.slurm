#!/bin/bash
#SBATCH --job-name=gemm_test
#SBATCH --output=gemm_test_%j.out
#SBATCH --error=gemm_test_%j.err
#SBATCH --time=00:05:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G

# 加载CUDA模块（根据集群配置调整）
module load cuda/11.8
module load gcc/9.3.0

# 显示环境信息
echo "=== Job Information ==="
echo "Job ID: $SLURM_JOB_ID"
echo "Node: $SLURMD_NODENAME"
echo "GPU: $CUDA_VISIBLE_DEVICES"
echo "Working Directory: $(pwd)"
echo "Date: $(date)"
echo ""

# 显示GPU信息
echo "=== GPU Information ==="
nvidia-smi
echo ""

# 编译程序
echo "=== Compiling ==="
make clean
make
echo ""

# 运行程序
echo "=== Running GEMM Test ==="
./simple_gemm
echo ""

# 显示结果
echo "=== Job Completed ==="
echo "End time: $(date)"
