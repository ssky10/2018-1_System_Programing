segment .text
global _fact

_fact:
push ebp
mov ebp,esp
mov eax,dword[ebp+8]
cmp eax,1
je done
dec eax
push eax
call _fact
mul dword[ebp+8]
done:
mov esp,ebp
pop ebp
ret
