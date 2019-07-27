%include "asm_io.inc"

segment     .data
prompt  db	"Input record : ", 0
outmsg1 db	"record size : ", 0
outmsg2 db	"Output record : ", 0
EOF db	"EOF", 10, 0

segment     .bss
BUFFER    resd    4096    ;문자열 저장공간

segment     .text
global  _COPY

%define     SIZEOF_INT  4
%define     ARRAY_SIZE  4096
%define     TEMP  [ebp - 4]

_COPY:
    push    ebp                 ; 호출 위치 스택 저장
    mov     ebp,    esp         ; esp의 값을 ebp로 복사
    sub     esp,    SIZEOF_INT  ; 스택에 하나의 int를 정의
    push    esi                 ; esi 저장
    mov     esi,    BUFFER      ; esi = ARRAYP
CLOOP:
    call    RDREC       ; RDREC호출
    call    WRREC       ; WRREC호출
    cmp     ebx,    0   ; 레코드의 크기가 0인가?
    jne     CLOOP       ; 0이 아니면 다시 반복
    pop     esi         ; esi 를 복원한다.
    jmp     short EXIT  ; EXIT로 이동

RDREC:
    push    ebp             ; 호출 위치 스택 저장
    mov     ebp,    esp     ; esp의 값을 ebp로 복사
    xor     ebx,    ebx     ; ebx = 배열 원소 위치 (자기자신을 XOR할경우 항상 0)
    mov     eax,    prompt  ;
    call    print_string    ;"Input record : "출력

RLOOP:
    cmp     ebx,    ARRAY_SIZE  ; ebx < ARRAY_SIZE 인가?
    jae     short EXIT          ; 아니면 루프 종료
    lea     eax,    TEMP        ; 스택에 정의한 int임시저장공간에 저장
	call	read_char           ; asm_io의 read_char 호출 (= call _getchar)
    mov     [esi + 4*ebx], eax  ; read_char의 반환값을 BUFFER에 순서대로 저장
    cmp     eax,    10          ; read_char가 10 을 리턴했는가?
    je      short EXIT          ; 맞으면 루프 종료
    inc     ebx                 ; ebx값 1증가
    jmp     RLOOP               ; RLOOP반복

EXIT:
    mov     eax,    ebx ; 리턴할 값을 eax 에 저장
    mov     esp,    ebp ; ebp의 값을 esp에 저장
    pop     ebp         ; ebp값 복구
    ret                 ; 호출된곳으로 리턴

WRREC:
    push    ebp             ; 호출 위치 스택 저장
    mov     ebp,    esp     ; esp의 값을 ebp로 복사
    mov     eax,    outmsg1 ;
    call    print_string    ; "record size :" 출력
    mov     eax,    ebx     ;
    call    print_int       ; 레코드의 크기 출력
    mov     eax,    10      ;
    call    print_char      ; 줄바꿈 출력
    mov     eax,    outmsg2 ;
    call    print_string    ; "Output recode :" 출력
    cmp     ebx,    0       ; 레코드의 크기가 0인가?
    je      EOFOUT          ; 0이면 EOF출력
    xor     ebx,    ebx     ; ebx = 배열 원소 위치 (자기자신을 XOR할경우 항상 0)

WLOOP:
    cmp     ebx,    ARRAY_SIZE  ; ebx < ARRAY_SIZE 인가?
    jae     short   EXIT        ; 아니면 루프 종료
    mov     eax,    [esi + 4*ebx];저장된 값을 순차적으로 eax로 복사
    call    print_char          ; asm_io의 print_char호출(= call _putchar)
    cmp     eax,    10          ; 저장된 값이 10인가?
    je      short EXIT          ; 일치하면 루프 종료
    inc     ebx                 ; ebx값 1증가
    jmp     WLOOP               ; WLOOP반복

EOFOUT:
    mov     eax,    EOF   ; eax에 EOF주소 복사
    call    print_string  ; EOF출력
    jmp     EXIT          ; 일치하면 루프 종료
