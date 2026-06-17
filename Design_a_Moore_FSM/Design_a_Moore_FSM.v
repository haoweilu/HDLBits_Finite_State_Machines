module top_module(
        input            clk    ,
        input            reset  ,
        input  [3:1]     s      ,
        output           fr3    ,
        output           fr2    ,
        output           fr1    ,
        output           dfr 
);

        parameter        emty            = 2'b00                                                           ;
        parameter        one_thirds_full = 2'b01                                                           ;
        parameter        two_thirds_full = 2'b10                                                           ;
        parameter        full            = 2'b11                                                           ;

        reg     [1:0]    Cur_state                                                                         ;
        reg     [1:0]    Next_state                                                                        ;

        always @(*) begin
                         case(s)
                                  3'b111 : Next_state = full                                               ;
                                  3'b011 : Next_state = two_thirds_full                                    ;
                                  3'b001 : Next_state = one_thirds_full                                    ;
                                  3'b000 : Next_state = emty                                               ;
                                 default : Next_state = emty                                               ;
                         endcase
        end

        always @(posedge clk) begin
               if (reset)                       begin
                        Cur_state <= emty                                                                  ;
               end
               else                             begin
                        Cur_state <= Next_state                                                            ;
               end
        end

        always @(posedge clk) begin
               if      (reset)                  begin
                              dfr <= 1'b1                                                                  ;
               end
               else if (Next_state < Cur_state) begin
                              dfr <= 1'b1                                                                  ;
               end
               else if (Next_state > Cur_state) begin                                                     
                              dfr <= 1'b0                                                                  ;
               end  
        end

        assign fr3 = (Cur_state == emty)                                                                   ;
        assign fr2 = (Cur_state == emty) | (Cur_state == one_thirds_full)                                  ;
        assign fr1 = (Cur_state == emty) | (Cur_state == one_thirds_full) | (Cur_state == two_thirds_full) ;

endmodule
