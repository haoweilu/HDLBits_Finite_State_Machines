module top_module(
        input            clk    ,
        input            areset ,
        input            x      ,
        output           z
);

        parameter        A = 1'b0                                                              ;
        parameter        B = 1'b1                                                              ;

        reg              Cur_state                                                             ;
        reg              Next_state                                                            ;

        always @(*)                             begin
                                                     case(Cur_state)
                                                                    A : Next_state = x ? B : A ;
                                                                    B : Next_state = B         ;
                                                     endcase
        end

        always @(posedge clk or posedge areset) begin
               if (areset)                           begin
                          Cur_state <= A                                                       ;
               end
               else                                  begin
                          Cur_state <= Next_state                                              ;
               end
        end

        assign z = (Cur_state == A && Next_state == B) || (Cur_state == B && x == 1'b0)        ;

endmodule
