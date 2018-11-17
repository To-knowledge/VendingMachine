module processing(
	input [4:0] money_buffer_i,
	input [3:0] price_i,
	output temp_o
	);

	assign temp_o = money_buffer_i >= price_i ? 1'b1 : 1'b0;
endmodule // processing