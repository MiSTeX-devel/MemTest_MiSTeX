`timescale 1 ps / 1 ps
module sysmem_lite
(
	output         clock,
	output         reset_out,

	input          reset_hps_cold_req,
	input          reset_hps_warm_req,
	input          reset_core_req,

	input          ram1_clk,
	input   [28:0] ram1_address,
	input    [7:0] ram1_burstcount,
	output         ram1_waitrequest,
	output  [63:0] ram1_readdata,
	output         ram1_readdatavalid,
	input          ram1_read,
	input   [63:0] ram1_writedata,
	input    [7:0] ram1_byteenable,
	input          ram1_write,

	input          ram2_clk,
	input   [28:0] ram2_address,
	input    [7:0] ram2_burstcount,
	output         ram2_waitrequest,
	output  [63:0] ram2_readdata,
	output         ram2_readdatavalid,
	input          ram2_read,
	input   [63:0] ram2_writedata,
	input    [7:0] ram2_byteenable,
	input          ram2_write,

	input          vbuf_clk,
	input   [27:0] vbuf_address,
	input    [7:0] vbuf_burstcount,
	output         vbuf_waitrequest,
	output [127:0] vbuf_readdata,
	output         vbuf_readdatavalid,
	input          vbuf_read,
	input  [127:0] vbuf_writedata,
	input   [15:0] vbuf_byteenable,
	input          vbuf_write
);

assign reset_out = ~init_reset_n | reset_core_req;

////////////////////////////////////////////////////////
////          f2sdram_safe_terminator_ram1          ////
////////////////////////////////////////////////////////
wire  [28:0] f2h_ram1_address;
wire   [7:0] f2h_ram1_burstcount;
wire         f2h_ram1_waitrequest;
wire  [63:0] f2h_ram1_readdata;
wire         f2h_ram1_readdatavalid;
wire         f2h_ram1_read;
wire  [63:0] f2h_ram1_writedata;
wire   [7:0] f2h_ram1_byteenable;
wire         f2h_ram1_write;

(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg ram1_reset_0 = 1'b1;
(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg ram1_reset_1 = 1'b1;
always @(posedge ram1_clk) begin
	ram1_reset_0 <= reset_out;
	ram1_reset_1 <= ram1_reset_0;
end

f2sdram_safe_terminator #(64, 8) f2sdram_safe_terminator_ram1
(
	.clk                      (ram1_clk),
	.rst_req_sync             (ram1_reset_1),

	.waitrequest_slave        (ram1_waitrequest),
	.burstcount_slave         (ram1_burstcount),
	.address_slave            (ram1_address),
	.readdata_slave           (ram1_readdata),
	.readdatavalid_slave      (ram1_readdatavalid),
	.read_slave               (ram1_read),
	.writedata_slave          (ram1_writedata),
	.byteenable_slave         (ram1_byteenable),
	.write_slave              (ram1_write),

	.waitrequest_master       (f2h_ram1_waitrequest),
	.burstcount_master        (f2h_ram1_burstcount),
	.address_master           (f2h_ram1_address),
	.readdata_master          (f2h_ram1_readdata),
	.readdatavalid_master     (f2h_ram1_readdatavalid),
	.read_master              (f2h_ram1_read),
	.writedata_master         (f2h_ram1_writedata),
	.byteenable_master        (f2h_ram1_byteenable),
	.write_master             (f2h_ram1_write)
);

////////////////////////////////////////////////////////
////          f2sdram_safe_terminator_ram2          ////
////////////////////////////////////////////////////////
wire  [28:0] f2h_ram2_address;
wire   [7:0] f2h_ram2_burstcount;
wire         f2h_ram2_waitrequest;
wire  [63:0] f2h_ram2_readdata;
wire         f2h_ram2_readdatavalid;
wire         f2h_ram2_read;
wire  [63:0] f2h_ram2_writedata;
wire   [7:0] f2h_ram2_byteenable;
wire         f2h_ram2_write;

(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg ram2_reset_0 = 1'b1;
(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg ram2_reset_1 = 1'b1;
always @(posedge ram2_clk) begin
	ram2_reset_0 <= reset_out;
	ram2_reset_1 <= ram2_reset_0;
end

f2sdram_safe_terminator #(64, 8) f2sdram_safe_terminator_ram2
(
	.clk                      (ram2_clk),
	.rst_req_sync             (ram2_reset_1),

	.waitrequest_slave        (ram2_waitrequest),
	.burstcount_slave         (ram2_burstcount),
	.address_slave            (ram2_address),
	.readdata_slave           (ram2_readdata),
	.readdatavalid_slave      (ram2_readdatavalid),
	.read_slave               (ram2_read),
	.writedata_slave          (ram2_writedata),
	.byteenable_slave         (ram2_byteenable),
	.write_slave              (ram2_write),

	.waitrequest_master       (f2h_ram2_waitrequest),
	.burstcount_master        (f2h_ram2_burstcount),
	.address_master           (f2h_ram2_address),
	.readdata_master          (f2h_ram2_readdata),
	.readdatavalid_master     (f2h_ram2_readdatavalid),
	.read_master              (f2h_ram2_read),
	.writedata_master         (f2h_ram2_writedata),
	.byteenable_master        (f2h_ram2_byteenable),
	.write_master             (f2h_ram2_write)
);

////////////////////////////////////////////////////////
////          f2sdram_safe_terminator_vbuf          ////
////////////////////////////////////////////////////////
wire  [27:0] f2h_vbuf_address;
wire   [7:0] f2h_vbuf_burstcount;
wire         f2h_vbuf_waitrequest;
wire [127:0] f2h_vbuf_readdata;
wire         f2h_vbuf_readdatavalid;
wire         f2h_vbuf_read;
wire [127:0] f2h_vbuf_writedata;
wire  [15:0] f2h_vbuf_byteenable;
wire         f2h_vbuf_write;

(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg vbuf_reset_0 = 1'b1;
(* altera_attribute = {"-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS"} *) reg vbuf_reset_1 = 1'b1;
always @(posedge vbuf_clk) begin
	vbuf_reset_0 <= reset_out;
	vbuf_reset_1 <= vbuf_reset_0;
end

f2sdram_safe_terminator #(128, 8) f2sdram_safe_terminator_vbuf
(
	.clk                      (vbuf_clk),
	.rst_req_sync             (vbuf_reset_1),

	.waitrequest_slave        (vbuf_waitrequest),
	.burstcount_slave         (vbuf_burstcount),
	.address_slave            (vbuf_address),
	.readdata_slave           (vbuf_readdata),
	.readdatavalid_slave      (vbuf_readdatavalid),
	.read_slave               (vbuf_read),
	.writedata_slave          (vbuf_writedata),
	.byteenable_slave         (vbuf_byteenable),
	.write_slave              (vbuf_write),

	.waitrequest_master       (f2h_vbuf_waitrequest),
	.burstcount_master        (f2h_vbuf_burstcount),
	.address_master           (f2h_vbuf_address),
	.readdata_master          (f2h_vbuf_readdata),
	.readdatavalid_master     (f2h_vbuf_readdatavalid),
	.read_master              (f2h_vbuf_read),
	.writedata_master         (f2h_vbuf_writedata),
	.byteenable_master        (f2h_vbuf_byteenable),
	.write_master             (f2h_vbuf_write)
);

reg init_reset_n = 0;
always @(posedge clock) begin
	integer timeout = 0;

	if(timeout < 2000000) begin
		init_reset_n <= 0;
		timeout <= timeout + 1;
	end
	else init_reset_n <= 1;
end

endmodule

