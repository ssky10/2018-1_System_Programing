segment .text
global _sum

_sum:
push ebp
mov ebp,esp
mov eax,dword[ebp+8]
cmp eax,1
je done
dec eax
push eax
call _sum
add eax, [ebp+8]
done:
mov esp,ebp
pop ebp
ret
