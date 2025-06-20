AHB Transfer:
(types)
Address phase: add is passed    and
Data phase: data is passed
NOTE: BOth take 1 clock cycle to get completed

Hwrite=1 M->S Write operation/transfer (write into hwdata[31:0])
Hwrite=0 S->M Read operation/transfer  (read into hrdata[31:0])

Hready=1: S is ready to read/write the data. or slave is willing to transfer the data
Hready=0: S is not ready to do anything
____________________________________________________________________________________

Transfer type: 
Htrans[1:0] 
if 00: idle transfer
   01: busy transfer 
   10: non sequential transfer
   11: sequential transfer 

Burst Transfers in AHB:
refers to the sequence of data transfers betwee master and slave.
(types) 
Incremental Burst: address keeps on incrementing
eg: A0-> A1-> A2 -> A3
Wrapping Burst: address increments but it will wrap around to initial address after reaching certain boundary. Utilizatio of memory is done nicely.
eg: A0-> A1 -> A2 -> A0

How to calculate wrap address:
Wrap boundary= (INT(Start_Address/(Number_Bytes x Burst_Length))) x (Number_Bytes X Burst_Length)

Address_N= Wrap_boundary + Number_Bytes X Burst_Length 
_____________________________________________________________________________________

Waited tranfers in amba:

Transfer Type during wait states: When the slave has requested wait states (i.e. when Hready=0), the master cannot change the transfer type, except as described in:
1. idle trnasfer
2. busy transfer, fixed lenght burst   (busy to seq)
3. busy transfer, undefined lenght burst

Exception:
Even during wait states, master can change Transfer type from idle to non-sequential.



