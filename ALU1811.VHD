LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY ALU181 IS
    PORT (
        S  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0 );
        M  : IN  STD_LOGIC;
        CN : IN  STD_LOGIC;
        B  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        A  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
        F  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      COUT : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        MM : IN  STD_LOGIC_VECTOR(24 DOWNTO 1);
        CO : OUT STD_LOGIC;
       EQ  : OUT STD_LOGIC;
       T4  :  IN STD_LOGIC;
       T1  :  IN STD_LOGIC
     );
END ALU181;
ARCHITECTURE behav OF ALU181 IS

SIGNAL A9 : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL B9 : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL AA : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL BB : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL F9 : STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL FK : STD_LOGIC ;

BEGIN
  AA <= '0' & A ;  BB <= '0' & B ;
  PROCESS(M,CN,A9,B9)
   BEGIN
      CASE S  IS
    	WHEN "0000" =>  IF M='0' THEN F9<=A9 + CN                ; ELSE  F9<=NOT A9; END IF;
        WHEN "0001" =>  IF M='0' THEN F9<=(A9 OR B9) + CN        ; ELSE  F9<=NOT(A9 OR B9); END IF;
        WHEN "0010" =>  IF M='0' THEN F9<=(A9 OR (NOT B9))+ CN   ; ELSE  F9<=(NOT A9) AND B9; END IF;
        WHEN "0011" =>  IF M='0' THEN F9<= "000000000" - CN      ; ELSE  F9<="000000000"; END IF;
        WHEN "0100" =>  IF M='0' THEN F9<=A9+(A9 AND NOT B9)+ CN ; ELSE  F9<=NOT (A9 AND B9); END IF;
        WHEN "0101" =>  IF M='0' THEN F9<=(A9 OR B9)+(A9 AND NOT B9)+CN ; ELSE  F9<=NOT B9; END IF;
        WHEN "0110" =>  IF M='0' THEN F9<=A9 -B9 - CN            ; ELSE  F9<=A9 XOR B9; END IF;
        WHEN "0111" =>  IF M='0' THEN F9<=(A9 AND (NOT B9)) - CN ; ELSE  F9<=A9 AND (NOT B9); END IF;
        WHEN "1000" =>  IF M='0' THEN F9<=A9 + (A9 AND B9)+CN    ; ELSE  F9<=(NOT A9) OR B9; END IF;
        WHEN "1001" =>  IF M='0' THEN F9<=A9 + B9 + CN           ; ELSE  F9<=NOT(A9 XOR B9); END IF;
        WHEN "1010" =>  IF M='0' THEN F9<=(A9 OR (NOT B9))+(A9 AND B9)+CN ; ELSE  F9<=B9; END IF;
        WHEN "1011" =>  IF M='0' THEN F9<=(A9 AND B9)- CN        ; ELSE  F9<=A9 AND B9; END IF;
        WHEN "1100" =>  IF M='0' THEN F9<=A9 + A9 + CN           ; ELSE  F9<= "000000001"; END IF;
        WHEN "1101" =>  IF M='0' THEN F9<=(A9 OR B9) + A9 + CN   ; ELSE  F9<=A9 OR (NOT B9); END IF;
        WHEN "1110" =>  IF M='0' THEN F9<=(A9 OR(NOT B9)) +A9 + CN ; ELSE  F9<=A9 OR B9; END IF;
        WHEN "1111" =>  IF M='0' THEN F9<=A9 -CN                 ; ELSE  F9<=A9 ; END IF;
        WHEN OTHERS  => F9<= "000000000" ;
      END CASE;
   END PROCESS;

  EQ <= (F9(7) AND F9(6) AND F9(5) AND F9(4)) OR (F9(3) AND F9(2) AND F9(1) AND F9(07));    
  
COUT <= "000" & CO;
  PROCESS(MM,T4 )
    BEGIN
        IF MM = "100101011001101000000001" THEN FK<='1' ;   -- 959A01H --这里需修改以适应更多的会产生进位的指令                
          ELSE FK<='0' ;
        END IF;
  END PROCESS; 

   PROCESS(FK,T4 )
    BEGIN
     IF falling_edge(FK) THEN  CO <= F9(8) ;  
        END IF;
  END PROCESS;
  F<= F9(7 DOWNTO 0) ;  
PROCESS(MM,T1)
    BEGIN
        IF MM = "100101011001101000000001" THEN   -- 959A01H --这里需修改以适应更多的会产生进位的指               
          ELSIF rising_edge(T1) THEN   A9 <= AA ; B9 <= BB ;
        END IF;
  END PROCESS;
END behav;




