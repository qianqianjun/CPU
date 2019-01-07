module ALU181A (S, A, B, F, M, CN, CO, FZ);
   input[3:0] S; input[7:0] A,B;  input M, CN;  
   output[7:0] F; output CO, FZ; 
   wire[7:0] F;   wire CO;wire[8:0] A9, B9;  reg FZ;   reg[8:0] F9; 
   assign A9 = {1'b0, A} ;  assign B9 = {1'b0, B} ;
   always @(M or CN or A9 or B9 or S) begin  
    case (S)
      4'b0000 : if (M==0)  F9<=A9+CN ;                else  F9<=~A9;  
      4'b0001 : if (M==0)  F9 <= (A9 |B9) + CN ;      else  F9<=~(A9 | B9) ;
      4'b0010 : if (M==0)  F9 <= (A9 |(~B9))+ CN;     else  F9<=(~A9) & B9 ; 
      4'b0011 : if (M==0)  F9 <= 9'b000000000-CN;     else  F9<=9'b000000000;
      4'b0100 : if (M==0)  F9 <=A9+(A9 & ~B9)+CN;     else  F9<=~(A9 & B9) ;
      4'b0101 : if (M==0)  F9<=(A9|B9)+(A9& ~B9)+CN;  else  F9<= ~B9 ;
      4'b0110 : if (M==0)  F9 <= A9 - B9 - CN ;       else  F9<= A9 ^ B9 ;
      4'b0111 : if (M==0)  F9 <= (A9 & (~B9)) - CN ;  else  F9<= A9 & (~B9) ;
      4'b1000 : if (M==0)  F9 <= A9 + (A9 & B9)+CN ;  else  F9<= (~A9) | B9 ;
      4'b1001 : if (M==0)  F9 <= A9 + B9 + CN ;       else  F9<= ~(A9 ^ B9) ;
      4'b1010 : if (M==0)  F9<=(A9|(~B9))+(A9&B9)+CN; else  F9<= B9 ;
      4'b1011 : if (M==0)  F9 <= (A9 & B9) - CN ;     else  F9<=A9 & B9 ;
      4'b1100 : if (M==0)  F9 <= A9 + A9 + CN ;       else  F9<=9'b000000001 ;
      4'b1101 : if (M==0)  F9 <= (A9 | B9)+A9+CN;     else  F9<= A9 | (~B9) ;
      4'b1110 : if (M==0)  F9 <= (A9 | (~B9))+A9+CN;  else  F9<= A9 | B9 ;
      4'b1111 : if (M==0)  F9 <= A9 - CN ;            else  F9<= A9 ;
         default : F9 <= 9'b000000000 ;
      endcase 
      if (A9 == B9) FZ <= 1'b0 ; else  FZ <= 1'b1 ; 
      end
   assign F = F9[7:0] ;   assign CO = F9[8] ;
endmodule
