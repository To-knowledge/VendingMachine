module putting_money(
			input num_twenty_i,
			input num_ten_i,
			input [1:0]num_five_i,
			input [3:0] num_one_i,
			output [4:0] money_buffer_o
);
		assign money_buffer_o = twenty + ten + five + num_one_i;
		
		reg [3:0] ten;
		reg [3:0] five;
		wire [4:0] twenty;
		
		assign twenty = (num_twenty_i == 1'b1)? 5'b10100 : 5'b0;
		
		always@(num_five_i)
		begin
							case(num_five_i)
										2'b01:
														five = 4'b0101;
										2'b10:
														five = 4'b1010;
										default:
														five = 4'b0;
							endcase
			end
			
			always@(num_ten_i)
			begin
							case(num_ten_i)
										1'b1:
														ten = 4'b1010;
										default:
														ten = 4'b0;
							endcase
			end
endmodule