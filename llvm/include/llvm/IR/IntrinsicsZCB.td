// poiner type.
def llvm_ptrf16_ty : LLVMPointerType<llvm_half_ty>;  // f16*

let TargetPrefix = "riscv" in {
  // veadd
  def int_riscv_veadd_mm
      : Intrinsic<[],
                  [llvm_ptrf16_ty, llvm_ptrf16_ty, llvm_ptrf16_ty],
                  [IntrArgMemOnly, NoCapture<ArgIndex<0>>,
                   NoCapture<ArgIndex<1>>, NoCapture<ArgIndex<2>>,
                   WriteOnly<ArgIndex<0>>, ReadOnly<ArgIndex<1>>,
                   ReadOnly<ArgIndex<2>>]>;
}
// veadd.mm (rd),(rs1),(rs2)
// llvm/include/llvm/IR/Intrinsics.td 