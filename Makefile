# Makefile for Simple GEMM Test
# 适用于教学集群的C++编译

# 编译器
CXX = g++

# 编译选项
CXX_FLAGS = -O2 -std=c++11 -Wall
CXX_FLAGS += -march=native

# 目标文件
TARGET = simple_gemm
SOURCE = simple_gemm.cpp

# 默认目标
all: $(TARGET)

# 编译规则
$(TARGET): $(SOURCE)
	$(CXX) $(CXX_FLAGS) -o $(TARGET) $(SOURCE)

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
