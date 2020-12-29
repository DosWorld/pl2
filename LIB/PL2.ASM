;
; MIT License
;
; Copyright (c) 2020 Viacheslav Komenda
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
;
; --------------------------------------------
        jmp near length
        jmp near strcpy
        jmp near strcmp
        jmp near strupr
        jmp near strlwr
        jmp near ucase
        jmp near lcase
        jmp near is_digit
        jmp near is_alpha
        jmp near is_id
        jmp near strhash
; --------------------------------------------
length:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     si,word[bp+4]
        xor     cx,cx
.loc1:  lodsb
        test    al,al
        je      .loc2
        inc     cx
        jmp     short .loc1
.loc2:  mov     ax,cx
        pop     bp
        ret     2
; --------------------------------------------
strcpy:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     si,word[bp+4]
        mov     di,word[bp+6]
        cld
.loc3:  lodsb
        stosb
        or      al,al
        je      .loc4
        jmp     short .loc3
.loc4:  mov     ax,di
        dec     ax
        pop     bp
        ret     4
; --------------------------------------------
strcmp:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     si,word[bp+6]
        mov     di,word[bp+4]
        cld
.loc5:  lodsb
        mov     ah,byte[di]
        inc     di
        cmp     al,ah
        jne     .loc6
        or      al,al
        jz      .loc6
        jmp     short .loc5
.loc6:  sub     al,ah
        cbw
        pop     bp
        ret     4
; --------------------------------------------
strupr:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     di,word[bp+4]
        mov     si,di
        cld
.loc7:  lodsb
        cmp     al,0x61
        jc      .loc8
        cmp     al,0x7a
        ja      .loc8
        sub     al,0x20
.loc8:  stosb
        or      al,al
        jnz     .loc7
        pop     bp
        ret     2
; --------------------------------------------
strlwr:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     di,word[bp+4]
        mov     si,di
        cld
.loc9:  lodsb
        cmp     al,0x61
        jc      .loc10
        cmp     al,0x7a
        ja      .loc10
        add     al,0x20
.loc10: stosb
        or      al,al
        jnz     .loc9
        pop     bp
        ret     2
; --------------------------------------------
ucase:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     ax,word[bp+4]
        cmp     al,0x61
        jc      .loc11
        cmp     al,0x7a
        ja      .loc11
        sub     al,0x20
.loc11: pop     bp
        ret     2

; --------------------------------------------
lcase:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     ax,word[bp+4]
        cmp     al,0x61
        jc      .loc12
        cmp     al,0x7a
        ja      .loc12
        add     al,0x20
.loc12: pop     bp
        ret     2
; --------------------------------------------
is_digit:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     ax,word[bp+4]
        xor     cx,cx
        cmp     al,0x30
        jc      .loc13
        cmp     al,0x39
        ja      .loc13
        dec     cx
.loc13: mov     ax,cx
        pop     bp
        ret     2
; --------------------------------------------
is_alpha:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     ax,word[bp+4]
        xor     cx,cx
        cmp     al,0x61
        jc      .loc14
        cmp     al,0x7a
        ja      .loc14
        dec     cx
        jmp     short .loc15
.loc14: cmp     al,0x41
        jc      .loc15
        cmp     al,0x5a
        ja      .loc15
        dec     cx
.loc15: mov     ax,cx
        pop     bp
        ret     2
; --------------------------------------------
is_id:
; --------------------------------------------
        push    bp
        mov     bp,sp
        mov     ax,word[bp+4]
        xor     cx,cx
        cmp     al,0x61
        jc      .loc16
        cmp     al,0x7a
        ja      .loc16
        dec     cx
        jmp     short .loc18
.loc16: cmp     al,0x41
        jc      .loc17
        cmp     al,0x5a
        ja      .loc17
        dec     cx
        jmp     short .loc18
.loc17: cmp     al,0x5f
        jne     .loc18
        dec     cx
.loc18: mov     ax,cx
        pop     bp
        ret     2
; --------------------------------------------
strhash:
        push    bp
        mov     bp,sp
        mov     si,word[bp+4]
        xor     bx,bx
        xor     ax,ax
        cld
.loc19:
        push    ax
        mov     cl,5
        shl     ax,cl
        pop     cx
        sub     ax,cx
        xchg    ax,bx
        lodsb
        add     bx,ax
        xchg    ax,bx
        or      bl,bl
        jne     .loc19
        pop     bp
        ret     2
; --------------------------------------------
