class mux_wr_xtn extends uvm_sequence_item;

	`uvm_object_utils(mux_wr_xtn)

	function new(string name="mux_wr_xtn");
		super.new(name);
	endfunction: new

	// Singals to the DUV
	randc bit [7:0] in;
	randc bit [2:0] sel;

	function void do_print(uvm_printer printer);
	
		// Printing IN bit by bit for better debugging	
		foreach(in[i])
			printer.print_field($sformatf("IN[%0d]",i), this.in[i], 1, UVM_BIN);
		printer.print_field("SEL", this.sel, 3, UVM_DEC);

	endfunction: do_print

endclass: mux_wr_xtn
