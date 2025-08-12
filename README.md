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

## Document

yml中添加了大量注释，进入.github/*.yml快速开始了解相关程序流程！

### CI_test.yml

这个CI用于CI测试，可以作为模板创建新的CI。

### CI_param_test.yml

这个CI用于CI测试，保证传递参数的正确性。可以作为模板创建新的CI。

### CI_GEM5_test.yml

这个CI用于GEM5的自动运行，是依照GEM5仓库下的CI进行的移植。目前仅支持一个spec06的checkpoint，待增加更多支持。

#### 具体参数

**script_path（string）**

含义：gem5 配置脚本路径（默认为kmhv2），最终会被 realpath 转为绝对路径传给 parallel_sim.sh。

默认：../gem5_config_kmhv2.sh

说明：工作目录在 artifacts/GEM5/util/xs_scripts/test，在运行前会把 artifacts/gem5_config_kmhv2.sh 复制到 ../gem5_config_kmhv2.sh，因此默认值可直接用。也可以传绝对路径。

**benchmark_type（string）**

含义：选择要跑的基准类型，决定检查点列表、评分脚本、集群配置与产物名称等。

默认：spec06-0.8c

当前支持：仅 spec06-0.8c。其他值会报错退出。

**check_result（boolean）**

含义：是否在检测到失败用例（存在 abort 文件）时让工作流失败。

默认：true

行为：true 发现失败即 exit 1，CI 标红。false 只汇报失败清单，不使 CI 失败。

### CI_QEMU_rvvplugin_test.yml

这个CI用于QEMU测试，通过使用QEMU plugin统计test case的bbl和rvv指令情况。

#### 具体参数

**test_case（string）**

含义：在 qemu-riscv64 下要执行的完整命令行，包含 RISC-V ELF 可执行程序路径及其参数。

默认：
/nfs/home/xutongqiao/checkpoint_tools/jiaxiaoyu_250314_elf/elf/xalancbmk -v /nfs/home/xutongqiao/checkpoint_tools/cpu2006v99/benchspec/CPU2006/483.xalancbmk/data/test/input/test.xml /nfs/home/xutongqiao/checkpoint_tools/cpu2006v99/benchspec/CPU2006/483.xalancbmk/data/test/input/xalanc.xsl

注意：

直接作为命令行参数传给 ./build/qemu-riscv64 -plugin ... -d plugin 执行，请填写“程序+参数”的整行命令，不要添加输出重定向（CI 已内置重定向到日志）。

建议使用绝对路径；目标必须是 riscv64 Linux 用户态 ELF。

### CI_RISCV_toolchain_test.yml

这个CI用于构建RISCV交叉编译器，包含jemalloc的过程，用于编译elf文件。

#### 具体参数

**is_vector（boolean）**

含义：是否生成支持vector扩展的交叉编译器

### CI_spec06_build.yml

这个CI用于使用编译器编译SPEC06 INT的elf文件。

#### 具体参数

**gcc-path（string）**

含义：RISC‑V 交叉编译工具链根目录。将被加入 PATH，并设置为 RISCV。

需求：目录下应有 bin/riscv64-unknown-linux-gnu-{gcc,g++,ar,ld,...}。

默认：/nfs/home/xutongqiao/apps/riscv-toolchain-build-vector

**spec-path（string）**

含义：SPEC CPU2006 根目录（应包含 benchspec/、shrc 等）。

行为：会被复制到工作目录下 cpu2006v99 再进行编译。注意这里的默认路径已经经过修改了，避免了相关bug

默认：/nfs/home/xutongqiao/checkpoint_tools/cpu2006v99

**compile-optimize（string）**

含义：传给编译器的优化与架构选项（传至 make OPTIMIZE="..."），参考CPU2006Wrapper相关提示。

默认：-O3 -flto -march=rv64gcv_zvl128b_zba_zbb_zbc_zbs -ftree-vectorize -mabi=lp64d -mrvv-max-lmul=m4 -mrvv-vector-bits=zvl

说明：需与工具链支持的指令扩展一致（如 RVV/zvl128b 等），否则会编译失败。