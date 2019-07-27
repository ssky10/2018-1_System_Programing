segment .text
global _max

_max:
push ebp
mov ebp,esp
mov eax,[ebp+12]
cmp [ebp+8], eax
jae FALSE
mov eax, dword[ebp+12]
jmp ENDIF
FALSE:
mov eax, dword[ebp+12]
ENDIF:
mov esp,ebp
pop ebp
ret
