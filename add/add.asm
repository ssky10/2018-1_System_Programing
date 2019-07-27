; add.asm
segment .bss
extern _sum

segment .text
global _add
_add:
  mov eax, [esp+4]
  add eax, [esp+8]
  mov [_sum], eax
  ret
