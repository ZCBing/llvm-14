
//===----------------------------------------------------------------------===//
//
//  This file describes the RISC-V ZCB instruction formats.
//
//===----------------------------------------------------------------------===//

//  31        26 25 24       20 19      15 14 13   12 11     7 6      0
//  |  funct6  | dmc |   rs2   |   rs1   | dm | opm2 |   rd   |1111011| OP-VE 
//  |    6     |  1  |    5    |    5    |  1 |   2  |    5   |   7   |

class RVInstZCB<bits<6> funct6, dag outs, dag ins,
                string opcodestr, string argstr>
    : RVInst<outs, ins, opcodestr, argstr, [], InstFormatV> {
  RISCVOpcode opcode = OPC_VE;
  bit dmc;
  bits<5> rs2;
  bits<5> rs1;
  bit dm;
  bits<2> opm2;
  bits<5> rd;

  let Inst{31 - 26} = funct6;
  let Inst{25} = dmc;
  let Inst{24 - 20} = rs2;
  let Inst{19 - 15} = rs1;
  let Inst{14} = dm;
  let Inst{13 - 12} = opm2;
  let Inst{11 - 7} = rd;
  
  let Opcode = opcode.Value;
}

class RVInstZCB_MM<bits<6> funct6, string opcodestr>
  : RVInstZCB<funct6, (outs),
              (ins GPR : $rd, GPR : $rs1, GPR : $rs2),
              opcodestr, "(${rd}), (${rs1}), (${rs2})"> {
    let dmc = 0;
    let dm = 0;
    let opm2 = 0b00;
}

def VEADD_MM : RVInstZCB_MM<0b000001, "veadd.mm">;

def addr : ComplexPattern<iPTR, 1, "SelectAddr",[], []>;

class PatAddrAddrAddr<SDPatternOperator OpNode, RVInst Inst>
    : Pat<(OpNode addr : $rd, addr : $rs1, addr : $rs2),
          (Inst addr : $rd, addr : $rs1, addr : $rs2)>;


def: PatAddrAddrAddr<int_riscv_veadd_mm, VEADD_MM>;