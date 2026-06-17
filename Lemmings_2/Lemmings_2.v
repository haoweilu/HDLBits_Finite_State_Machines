module top_module(
        input            clk        ,
        input            areset     ,
        input            bump_left  ,
        input            bump_right ,
        input            ground     ,
        output           walk_left  ,
        output           walk_right ,
        output           aaah        
);

        parameter        Left   = 2'b00                                                                                    ;
        parameter        Right  = 2'b01                                                                                    ;
        parameter        Fall_L = 2'b10                                                                                    ;
        parameter        Fall_R = 2'b11                                                                                    ;

        reg       [1:0]  Cur_state                                                                                         ;
        reg       [1:0]  Next_state                                                                                        ;

        always @(*)                            begin
               if (ground)                           begin
                                                           case(Cur_state)
                                                                          Left   : Next_state = bump_left  ? Right : Left  ;
                                                                          Right  : Next_state = bump_right ? Left : Right  ;
                                                                          Fall_L : Next_state = Left                       ;
                                                                          Fall_R : Next_state = Right                      ;
                                                           endcase
               end                                   
               else                                  begin
                                                           case(Cur_state)
                                                                          Left   : Next_state = Fall_L                     ;
                                                                          Right  : Next_state = Fall_R                     ;
                                                                          Fall_L : Next_state = Fall_L                     ;
                                                                          Fall_R : Next_state = Fall_R                     ;
                                                           endcase
               end
        end

        always @(posedge clk or posedge areset) begin
               if (areset)                           begin
                          Cur_state <= Left                                                                                ;
               end
               else                                  begin
                          Cur_state <= Next_state                                                                          ;
               end 
        end

        assign walk_left  = (Cur_state == Left)                                                                            ;
        assign walk_right = (Cur_state == Right)                                                                           ;
        assign aaah       = (Cur_state == Fall_L) | (Cur_state == Fall_R)                                                  ;

endmodule
