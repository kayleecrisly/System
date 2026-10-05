#ifndef CLK_ANALYSIS_RESULT_H
#define CLK_ANALYSIS_RESULT_H

#include <cstdint>
#include <string>
#include <vector>

namespace clk_analysis {

struct APBRegisterMapping {
  uint64_t address = 0;
  std::string registerName;
  unsigned bitWidth = 0;
  bool isWritable = false;
  bool isReadable = false;
  bool isW1C = false;
};

struct AddressConflict {
  uint64_t address = 0;
  std::vector<std::string> registerNames;
};

struct CombinationalAssignment {
  std::string targetSignal;
  std::string expression;
  unsigned bitWidth = 0;
  // Bug G: when targetSignal is a wide-array (>128 bits, stored as
  // uint64_t arr[N]), wordIndex selects which 64-bit word this
  // assignment writes.  -1 = whole signal (scalar storage, or whole
  // array copy).  >=0 = element index into the uint64_t array.
  int wordIndex = -1;
  // Comb SCC bookkeeping (set by the emitter's topological sort): assignments
  // that belong to a CYCLIC strongly-connected component (genuine
  // combinational loops — valid/ready handshakes, FSM comb blocks that read
  // their own outputs through other always_comb blocks) share an sccId and
  // are emitted inside a small local fixed-point loop, so a single
  // update_state() converges them instead of relying on the outer settle.
  int sccId = -1;
  bool sccCyclic = false;
  // Sequential-domain id: assignments unrolled from the SAME non-clocked
  // llhd.process carry one id (-1 = not from a process).  Inside a domain
  // the drv order IS the blocking-assignment program order, so a read of a
  // signal written LATER in the same domain refers to the previous
  // delta's value — not a topological dependency.  The emitter's sorter
  // treats such backward same-domain references as weak: they build no
  // edge (a serialized read-modify-write chain like prim_subst_perm's
  // sbox/flip/butterfly is NOT a comb loop — iterating it composes the
  // non-idempotent permutation 8x), but their presence marks the domain
  // as a genuine comb cycle that still needs the local fixed point.
  int seqDomain = -1;
};

} // namespace clk_analysis

#endif
