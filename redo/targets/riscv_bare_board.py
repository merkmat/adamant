from base_classes.gprbuild_target_base import gprbuild_target_base

# This file contains a build target base class that should
# work well for most riscv 32-bit bare board targets.


class riscv_bare_board(gprbuild_target_base):
    def path_files(self):
        """RISCV bare board targets contain the 32bit and bb (bareboard) path files."""
        return super(riscv_bare_board, self).path_files() + ["32bit", "bb"]

    def gnatmetric_info(self, target=""):
        """gatmetric info for riscv bare board implementations."""
        # Return a tuple of:
        # gnatmetric prefix (ie. "riscv32-elf-")
        prefix = "riscv32-elf-"
        # gnat metric flags
        flags = ""
        return prefix, flags
