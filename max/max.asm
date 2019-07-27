segment .bss
extern _result

segment .text
global _max

_max:
push ebp
mov ebp,esp
sub esp,4
mov eax,[ebp+12]
cmp [ebp+8], eax
jae FALSE
push dword[ebp+12]
jmp ENDIF
FALSE:
push dword[ebp+8]
ENDIF:
pop dword[_result]
mov esp,ebp
pop ebp
ret
