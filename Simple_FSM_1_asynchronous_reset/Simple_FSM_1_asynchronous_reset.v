module top_module(
        input             clk    ,
        input             areset ,
        input             in     ,
        output            out
);

        parameter A = 1'b0                                    ;
        parameter B = 1'b1                                    ;

        reg       state                                       ;
        reg       next_state                                  ;

        wire      CurstateA                                   ;        
        wire      CurstateB                                   ; 
       
        assign    CurstateA = (state == A)                    ;
        assign    CurstateB = (state == B)                    ;

        always @(*)                            begin
               if      (CurstateA && in)             begin
                             next_state <= A                  ;
               end
               else if (CurstateA && !in)            begin
                             next_state <= B                  ;
               end
               else if (CurstateB && in)             begin
                             next_state <= B                  ;
               end
               else if (CurstateB && !in)            begin
                             next_state <= A                  ;
               end
        end

        always @(posedge clk, posedge areset)  begin
               if       (areset)                     begin
                             state <= B                       ;
               end
               else                                  begin
                             state <= next_state              ;
               end
        end

        assign   out = (state == B)                           ; 

endmodule
