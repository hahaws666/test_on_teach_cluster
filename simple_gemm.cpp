#include <iostream>
#include <vector>
#include <chrono>
#include <iomanip>

// 简单的矩阵乘法实现
void matrix_multiply(const std::vector<float>& A, const std::vector<float>& B, 
                     std::vector<float>& C, int m, int n, int k) {
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            float sum = 0.0f;
            for (int l = 0; l < k; ++l) {
                sum += A[i * k + l] * B[l * n + j];
            }
            C[i * n + j] = sum;
        }
    }
}

int main() {
    std::cout << "=== Simple GEMM Test (CPU Implementation) ===\n";
    
    // 矩阵维度
    const int m = 512, n = 512, k = 512;  // 减小尺寸以便CPU能够快速计算
    
    std::cout << "\nMatrix dimensions: " << m << " x " << k << " * " << k << " x " << n << " = " << m << " x " << n << "\n";
    std::cout << "Total elements: " << m * n << "\n";
    
    // 分配内存
    std::vector<float> A(m * k, 1.0f);
    std::vector<float> B(k * n, 2.0f);
    std::vector<float> C(m * n, 0.0f);
    
    // 预热
    matrix_multiply(A, B, C, m, n, k);
    
    // 计时
    const int iterations = 5;
    auto start_time = std::chrono::high_resolution_clock::now();
    
    for (int i = 0; i < iterations; ++i) {
        matrix_multiply(A, B, C, m, n, k);
    }
    
    auto end_time = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end_time - start_time);
    double ms = duration.count() / 1000.0 / iterations;
    
    // 计算性能
    double flops = 2.0 * m * n * k;
    double gflops = flops / (ms / 1000.0) / 1e9;
    
    std::cout << "\n=== Results ===\n";
    std::cout << "Average time: " << std::fixed << std::setprecision(3) << ms << " ms\n";
    std::cout << "Throughput: " << std::fixed << std::setprecision(3) << gflops << " GFLOPS\n";
    
    // 验证结果
    float expected = 1.0f * 2.0f * k;
    float actual = C[0];
    float error = std::abs(actual - expected) / expected;
    
    std::cout << "First element: " << actual << " (expected: " << expected << ")\n";
    std::cout << "Relative error: " << std::scientific << std::setprecision(2) << error << "\n";
    
    if (error < 1e-5) {
        std::cout << "✓ Test PASSED\n";
    } else {
        std::cout << "✗ Test FAILED\n";
    }
    
    std::cout << "\n=== Test completed ===\n";
    return 0;
}
