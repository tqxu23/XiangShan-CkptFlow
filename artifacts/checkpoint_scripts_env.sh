#!/usr/bin/bash

# could modify
export NEMU_HOME=/nfs/home/share/workload_env/NEMU
export QEMU_HOME=/nfs/home/share/workload_env/qemu
export GCPT_HOME=/nfs/home/share/workload_env/LibCheckpointAlpha

# Do not modify anything below this line
ARCH=riscv
export ARCH

LINUX_HOME=/nfs/home/share/workload_env/linux-6.10.2
export LINUX_HOME

OPENSBI_HOME=/nfs/home/share/workload_env/opensbi
export OPENSBI_HOME

XIANGSHAN_FDT=/nfs/home/share/workload_env/workload_build_env/dts/build/xiangshan.dtb
export XIANGSHAN_FDT

CROSS_COMPILE=/nfs/home/share/riscv-toolchain-gcc15-240613/bin/riscv64-unknown-linux-gnu-
export CROSS_COMPILE

CPU2017_RUN_DIR=/nfs/home/share/xs-workloads/spec/spec-all/cpu2017_run_dir
export CPU2017_RUN_DIR
CPU2006_RUN_DIR=/nfs/home/share/xs-workloads/spec/spec-all/cpu2006_run_dir
export CPU2006_RUN_DIR

RISCV=/nfs/home/share/riscv-toolchain-20230425
export RISCV

RISCV_ROOTFS_HOME=/nfs/home/share/workload_env/riscv-rootfs
export RISCV_ROOTFS_HOME
