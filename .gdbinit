define n
  next
  refresh
end

define s
  step
  refresh
end

define c
  continue
  refresh
end

set debuginfod enabled on

set disassembly-flavor intel
# set disassembly-flavor att

tui new-layout completo {-horizontal src 1 asm 1} 2 regs 1 status 0 cmd 1
