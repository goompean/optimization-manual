#
# Copyright (C) 2021 by Intel Corporation
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.
#

	.intel_syntax noprefix

	.globl _divps_sse
	.globl divps_sse

	# void divps_sse(float *in1, float *in2, float *out, size_t len)
	# On entry:
	#     rdi = in1
	#     rsi = in2
	#     rdx = out
	#     rcx = len

	.text

_divps_sse:
divps_sse:

	push rbx

	mov rax, rdi
	mov rbx, rsi
	mov rsi, rcx
	shl rsi, 2    # rsi is size of inputs in bytes
	mov rcx, rdx
	xor rdx, rdx

loop1:
	movups xmm0, [rax+rdx*1]
	movups xmm1, [rbx+rdx*1]
	divps xmm0, xmm1
	movups [rcx+rdx*1], xmm0
	add rdx, 16
	cmp rdx, rsi
	jl loop1

	pop rbx
	ret

#if defined(__linux__) && defined(__ELF__)
.section .note.GNU-stack,"",%progbits
#endif
