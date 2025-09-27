# Makefile for Simple GEMM Test
# 适用于教学集群的CUDA编译

# 编译器
NVCC = nvcc

# 编译选项
NVCC_FLAGS = -O3 -std=c++11 -arch=sm_60
NVCC_FLAGS += -lcublas -lcudart

# 目标文件
TARGET = simple_gemm
SOURCE = simple_gemm.cu

# 默认目标
all: $(TARGET)

# 编译规则
$(TARGET): $(SOURCE)
	$(NVCC) $(NVCC_FLAGS) -o $(TARGET) $(SOURCE)

# 清理
clean:
	rm -f $(TARGET)

# 运行测试
run: $(TARGET)
	./$(TARGET)

# 帮助信息
help:
	@echo "Available targets:"
	@echo "  all     - Compile the program (default)"
	@echo "  clean   - Remove compiled files"
	@echo "  run     - Compile and run the program"
	@echo "  help    - Show this help message"

.PHONY: all clean run help
