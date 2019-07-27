segment .text
global _sum

_sum:
push ebp
mov ebp,esp
push ebx
mov ebx,dword[ebp+8]
mov ecx,0
mov edx,1
again:
cmp edx,ebx
jg done
add ecx,edx
inc edx
jmp again
done:
mov eax,ecx
pop ebx
mov esp,ebp
pop ebp
ret
