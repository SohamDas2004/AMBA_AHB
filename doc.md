AHB Transfer:
(types) <br>
Address phase: add is passed    and
Data phase: data is passed
NOTE: Both take 1 clock cycle to get completed

Hwrite=1 M->S Write operation/transfer (write into hwdata[31:0])
<br>
Hwrite=0 S->M Read operation/transfer  (read into hrdata[31:0])

Hrdata: slave sends the data to master thru this bus

Hready=1: S is ready to read/write the data. or slave is willing to transfer the data
Hready=0: S is not ready to do anything
____________________________________________________________________________________

Transfer type: 
Htrans[1:0] 
if <br>00: idle transfer
   <br>01: busy transfer 
   <br>10: non sequential transfer
   <br>11: sequential transfer 

Burst Transfers in AHB:
refers to the sequence of data transfers betwee master and slave. <br>
(types) <br>
Incremental Burst: address keeps on incrementing
eg: A0-> A1-> A2 -> A3 <br>
Wrapping Burst: address increments but it will wrap around to initial address after reaching certain boundary. Utilizatio of memory is done nicely.
eg: A0-> A1 -> A2 -> A0

How to calculate wrap address:
Wrap boundary= (INT(Start_Address/(Number_Bytes x Burst_Length))) x (Number_Bytes X Burst_Length)

Address_N= Wrap_boundary + Number_Bytes X Burst_Length 
_____________________________________________________________________________________

Waited tranfers in amba:

Transfer Type during wait states: When the slave has requested wait states (i.e. when Hready=0), the master cannot change the transfer type, except as described in:
1. idle transfer
2. busy transfer, fixed lenght burst   (busy to seq)
3. busy transfer, undefined lenght burst

Exception:
Even during wait states, master can change Transfer type from idle to non-sequential.

Notes:<br>
Using an interconnet we are establishing connection between multiple masters and slaves

According to Haddr[31:0], Hsel will be selected i.e. a particular slave will be slected. For example: if slave 1 is selected then that slave will respond with hrdata, hresp, hreadyout

Address is given to the multiplexer as a select line to the mux and a slave is selected. 
_______________________________________________________________________________________

Slave Transfer Respone:

Hresp=0 --> okay signal | Hresp=1 --> error response

If Hresp=0 and Hreadyout=1 --> transfer has been completed successfully.<br>
If Hresp=0 and Hreadyout=0 --> additinal cycles are required for the slave to complete request. Transfer is pending. <br>
If Hresp=1 and Hreadyout=0 --> then error has occured and slave is not ready<br>
If Hresp=1 and Hreadyout=1 --> error response in second clock cycle 

________________________________________________________________________________________

File Architecture:<br>

Single Master and Multple slaves are chosen here.

AHB- Top module<br>
|<br>
--> AHB Master<br>
|<br>
--> AHB Slave<br>
|<br>
--> Decoder<br>
|<br>
--> Multiplexer<br>

Separate testbenches are given for all the modules mentioned above.  

_______________________________________________________________________________________





