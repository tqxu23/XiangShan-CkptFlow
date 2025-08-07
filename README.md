# XiangShan-CkptFlow

## Introduction

本仓库是用于性能探索的工具集合，使用GITHUB CI进行快速性能测试。

本仓库的最终目标是实现两套自动化的CI流程，用于RISC-V Vector分析。

1. 基于指令分析的工具流：Benchmark (SPEC) → Builder（SPEC06Wrapper）→ Compiler（RISCV-GNU-Toolchain）→ Simulator (QEMU) → Analysis Result

2. 基于性能分析的工具流：Benchmark (SPEC) → Builder（SPEC06Wrapper）→ Compiler（RISCV-GNU-Toolchain）→ Simpoint Packager (checkpoint_scripts/Deterload) → Simulator (GEM5) → Performance Result (Perfcct) → Source Code Analysis (Profiling-based Performance Tracing) → Analysis Result

分析的方法论细节可见相关文档：[自顶向下的RVV性能探索方法](https://bosc.yuque.com/yny0gi/sggyey/zh9o66kfo01asx5n)

## Quick Start

FORK该仓库 → 配置Actions Runner → 运行测试！

注：本仓库在小机房内运行，能够使用相关环境。若使用其他机器则需要注意修改CI内容