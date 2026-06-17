module top_module(
        input            clk        ,
        input            areset     ,
        input            bump_left  ,
        input            bump_right ,
        input            ground     ,
        input            dig        ,
        output           walk_left  ,
        output           walk_right ,
        output           aaah       ,
        output           digging 
);

        parameter        Left     = 3'b000 ;
        parameter        Right    = 3'b001 ;
        parameter        Fall_L   = 3'b010 ;
        parameter        Fall_R   = 3'b011 ;
        parameter        Dig_L    = 3'b100 ;
        parameter        Dig_R    = 3'b101 ;

        reg       [2:0]  Cur_state         ;
        reg       [2:0]  Next_state        ;

        always @(*) begin
               if (ground) begin
                                case(Cur_state)
                                               Left    :  Next_state = dig ? Dig_L : (bump_left ? Right : Left)     ;
                                               Right   :  Next_state = dig ? Dig_R : (bump_right ? Left : Right)    ;
                                               Fall_L  :  Next_state = Left                                         ;
                                               Fall_R  :  Next_state = Right                                        ;
                                               Dig_L   :  Next_state = Dig_L                                        ;
                                               Dig_R   :  Next_state = Dig_R                                        ;
                                               default :  Next_state = Left                                         ;
                                endcase
               end
               else        begin
                                case(Cur_state)
                                               Left    : Next_state = Fall_L                                        ;
                                               Right   : Next_state = Fall_R                                        ;
                                               Fall_L  : Next_state = Fall_L                                        ;
                                               Fall_R  : Next_state = Fall_R                                        ; 
                                               Dig_L   : Next_state = Fall_L                                        ; 
                                               Dig_R   : Next_state = Fall_R                                        ;
                                               default : Next_state = Fall_L                                        ;
                                endcase
               end
        end       

        always @(posedge clk or posedge areset) begin
               if (areset)                           begin
                          Cur_state <= Left                                                                         ;
               end
               else                                  begin
                          Cur_state <= Next_state                                                                   ;
               end 
        end

        assign walk_left  = (Cur_state == Left)                                                                     ;
        assign walk_right = (Cur_state == Right)                                                                    ;
        assign aaah       = (Cur_state == Fall_L) | (Cur_state == Fall_R)                                           ;
        assign digging    = (Cur_state == Dig_L)  | (Cur_state == Dig_R)                                            ;

endmodule
