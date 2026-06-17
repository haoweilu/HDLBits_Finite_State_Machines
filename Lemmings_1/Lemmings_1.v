module top_module(
        input            clk         ,
        input            areset      ,
        input            bump_left   ,
        input            bump_right  ,
        output           walk_left   ,
        output           walk_right  
);

        parameter        Left      = 1'b0                                                 ;
        parameter        Right     = 1'b1                                                 ;

        reg              Cur_state                                                        ;
        reg              Next_state                                                       ;

        always @(*) begin
                          case(Cur_state)
                                          Left  : Next_state = bump_left  ? Right : Left  ;
                                          Right : Next_state = bump_right ? Left  : Right ;
                          endcase
        end

        always @(posedge clk or posedge areset) begin
               if       (areset)                      begin
                             Cur_state <= Left                                            ;
               end
               else                                   begin
                             Cur_state <= Next_state                                      ;
               end
        end

        assign           walk_left  = (Cur_state == Left)                                 ;
        assign           walk_right = (Cur_state == Right)                                ;

endmodule
