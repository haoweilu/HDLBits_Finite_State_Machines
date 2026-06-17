module top_module(
        input        clk    ,
        input        reset ,
        input        j      , 
        input        k      ,
        output       out    
);

        parameter    OFF = 1'b0                                  ;
        parameter    ON  = 1'b1                                  ;

        reg          Cur_state                                   ;
        reg          Next_state                                  ;

        always @(*) begin
               case(Cur_state)
                            OFF:    Next_state = j ? ON  : OFF   ;
                            ON:     Next_state = k ? OFF : ON    ;
                           default: Next_state = OFF             ;
               endcase
        end

        always @(posedge clk) begin
               if  (reset)         begin
                       Cur_state <= OFF                          ;  
               end
               else                begin
                       Cur_state <= Next_state                   ;
               end
        end

        assign out = (Cur_state == ON)                           ;

endmodule

