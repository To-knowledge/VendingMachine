module change (
	input [4:0] price_i,
	input [4:0] money_buffer_i,
	output [2:0] type_one_o,
	output [1:0] type_five_o,
	output type_ten_o
);
	reg [2:0] type_one_r;
	reg [1:0] type_five_r;
	reg type_ten_r;
	
	wire [4:0] return_money_i;
	
	assign return_money_i = (money_buffer_i >= price_i)? (money_buffer_i - price_i) : money_buffer_i;
	assign type_one_o = type_one_r;
	assign type_five_o = type_five_r;
	assign type_ten_o = type_ten_r;

	always@(return_money_i)	begin
		if (return_money_i >= 5'b01111) begin
			type_ten_r <= 1'b1;
			type_five_r <= 2'b01;
			type_one_r <= return_money_i - 5'b01111;
		end

		else if (return_money_i >= 5'b01010) begin
			type_ten_r <= 1'b1;
			type_five_r <= 2'b00;
			type_one_r <= return_money_i - 5'b01010;
		end

		else if (return_money_i >= 5'b00101) begin
			type_ten_r <= 1'b0;
			type_five_r <= 2'b01;
			type_one_r <= return_money_i - 5'b00101;
		end

		else begin
			type_ten_r <= 1'b0;
			type_five_r <= 2'b00;
			type_one_r <= return_money_i;
		end
	end

endmodule