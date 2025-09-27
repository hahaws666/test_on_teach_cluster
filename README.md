# Simple GEMM Test for Teaching Cluster

这是一个简化的CUDA GEMM（矩阵乘法）测试程序，专为教学集群设计。

## 文件说明

- `simple_gemm.cu` - 主程序源代码
- `Makefile` - 编译配置文件
- `run_gemm.slurm` - SLURM作业提交脚本
- `README.md` - 使用说明

## 程序功能

- 执行1024x1024的矩阵乘法运算
- 使用cuBLAS库进行GPU加速
- 显示GPU信息和性能指标
- 验证计算结果的正确性

## 使用方法

### 1. 直接运行（如果有GPU访问权限）

```bash
# 编译
make

# 运行
./simple_gemm
```

### 2. 通过SLURM提交作业

```bash
# 提交作业
sbatch run_gemm.slurm

# 查看作业状态
squeue -u $USER

# 查看输出
cat gemm_test_*.out
```

## 预期输出

程序会显示：
- GPU设备信息
- 矩阵维度
- 平均执行时间
- 计算吞吐量（TFLOPS）
- 结果验证

## 注意事项

1. **模块加载**: 根据集群配置，可能需要调整`run_gemm.slurm`中的模块加载命令
2. **GPU架构**: 如果遇到架构不匹配，请修改`Makefile`中的`-arch=sm_60`参数
3. **时间限制**: 作业时间限制为5分钟，通常足够完成测试

## 故障排除

### 编译错误
- 检查CUDA模块是否正确加载
- 确认GPU架构设置正确

### 运行时错误
- 检查是否有GPU分配权限
- 确认CUDA驱动版本兼容

### 性能异常
- 检查GPU是否被其他进程占用
- 确认Tensor Core是否正常工作

## 扩展使用

可以修改`simple_gemm.cu`中的矩阵维度来测试不同大小的矩阵乘法：

```cpp
const int m = 2048, n = 2048, k = 2048;  // 更大的矩阵
```

## 联系信息

如有问题，请联系系统管理员或查看集群文档。
