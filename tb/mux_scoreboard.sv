class mux_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(mux_scoreboard)

	// Analysis FIFOs
	uvm_tlm_analysis_fifo#(mux_wr_xtn) wr_fifoh;
	uvm_tlm_analysis_fifo#(mux_rd_xtn) rd_fifoh;

	// Data handles
	mux_wr_xtn wr_mon_data;
	mux_rd_xtn rd_mon_data;

	// Coverage data handles
	mux_wr_xtn wr_cov_data;
	mux_rd_xtn rd_cov_data;

	// Config object handle
	mux_config m_cfg;

	// Covergroup definition
	covergroup wr_covgrp;
		IN0: coverpoint wr_cov_data.in[0]{
				bins HIGH 	= {1'b1};
				bins LOW 	= {1'b0};
			}
		IN1: coverpoint wr_cov_data.in[1]{
				bins HIGH 	= {1'b1};
				bins LOW 	= {1'b0};
			}
		IN2: coverpoint wr_cov_data.in[2]{
				bins HIGH 	= {1'b1};
				bins LOW 	= {1'b0};
			}
		IN3: coverpoint wr_cov_data.in[3]{
				bins HIGH 	= {1'b1};
				bins LOW 	= {1'b0};
			}
		IN4: coverpoint wr_cov_data.in[4]{
				bins HIGH 	= {1'b1};
				bins LOW 	= {1'b0};
			}
		IN5: coverpoint wr_cov_data.in[5]{
				bins HIGH 	= {1'b1};
				bins LOW 	= {1'b0};
			}
		IN6: coverpoint wr_cov_data.in[6]{
				bins HIGH 	= {1'b1};
				bins LOW 	= {1'b0};
			}
		IN7: coverpoint wr_cov_data.in[7]{
				bins HIGH 	= {1'b1};
				bins LOW 	= {1'b0};
			}
		SEL: coverpoint wr_cov_data.sel{
				bins SEL[8] = {[0:7]};
			}
	endgroup

	covergroup rd_covgrp;
		OUT: coverpoint rd_cov_data.out{
				bins OUT_0 = {1'b0};
				bins OUT_1 = {1'b1};
			}
	endgroup

	function new(string name="mux_scoreboard", uvm_component parent);
		super.new(name, parent);

		// Memory allocation for covergroup
		wr_covgrp = new();
		rd_covgrp = new();
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		// Getting the config object
		if(!uvm_config_db#(mux_config)::get(this, "", "mux_config", m_cfg))
			`uvm_fatal(get_type_name(), "FAILED TO GET CONFIG")

		// Memory allocating for FIFOs
		wr_fifoh = new("wr_fifoh", this);
		rd_fifoh = new("rd_fifoh", this);
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);

		forever begin
			// Collecting wr_mon data
			begin: wr_mon 
				wr_mon_data = mux_wr_xtn::type_id::create("wr_mon_data");
				wr_cov_data = mux_wr_xtn::type_id::create("wr_cov_data");

				wr_fifoh.get(wr_mon_data);
				m_cfg.sb_wr_mon++;
				`uvm_info(get_type_name(), $sformatf("\n\nSB DATA[%0d] FROM THE WR_MON:",m_cfg.sb_wr_mon), UVM_LOW)
				wr_mon_data.print();
				
				wr_cov_data = wr_mon_data;
				wr_covgrp.sample(); // Sampling source side covergroup
			end

			// Collecting wr_mon data
			begin: rd_mon 
				rd_mon_data = mux_rd_xtn::type_id::create("rd_mon_data");
				rd_cov_data = mux_rd_xtn::type_id::create("rd_cov_data");

				rd_fifoh.get(rd_mon_data);
				m_cfg.sb_rd_mon++;
				`uvm_info(get_type_name(), $sformatf("\n\nSB DATA[%0d] FROM THE RD_MON:",m_cfg.sb_rd_mon), UVM_LOW)
				rd_mon_data.print();
				
				rd_cov_data = rd_mon_data;
				rd_covgrp.sample(); // Sampling destination side covergroup

				// Sending the data to reference model
				compare(wr_mon_data, rd_mon_data); 
			end
		end

	endtask: run_phase

	// Reference model implementation
	function void compare(mux_wr_xtn wr_data, mux_rd_xtn rd_data);

		case(wr_data.sel)
			3'd0: begin
				if(wr_data.in[0] != rd_data.out)
					begin
						`uvm_info(get_type_name(), "DATA MISMATCH", UVM_LOW)
						m_cfg.sb_mismatch++;
					end
				else
					begin
						`uvm_info(get_type_name(), "DATA MATCHED", UVM_LOW)
						m_cfg.sb_matched++;
					end
			end
			3'd1: begin
				if(wr_data.in[1] != rd_data.out)
					begin
						`uvm_info(get_type_name(), "DATA MISMATCH", UVM_LOW)
						m_cfg.sb_mismatch++;
					end
				else
					begin
						`uvm_info(get_type_name(), "DATA MATCHED", UVM_LOW)
						m_cfg.sb_matched++;
					end
			end
			3'd2: begin
				if(wr_data.in[2] != rd_data.out)
					begin
						`uvm_info(get_type_name(), "DATA MISMATCH", UVM_LOW)
						m_cfg.sb_mismatch++;
					end
				else
					begin
						`uvm_info(get_type_name(), "DATA MATCHED", UVM_LOW)
						m_cfg.sb_matched++;
					end
			end
			3'd3: begin
				if(wr_data.in[3] != rd_data.out)
					begin
						`uvm_info(get_type_name(), "DATA MISMATCH", UVM_LOW)
						m_cfg.sb_mismatch++;
					end
				else
					begin
						`uvm_info(get_type_name(), "DATA MATCHED", UVM_LOW)
						m_cfg.sb_matched++;
					end
			end
			3'd4: begin
				if(wr_data.in[4] != rd_data.out)
					begin
						`uvm_info(get_type_name(), "DATA MISMATCH", UVM_LOW)
						m_cfg.sb_mismatch++;
					end
				else
					begin
						`uvm_info(get_type_name(), "DATA MATCHED", UVM_LOW)
						m_cfg.sb_matched++;
					end
			end
			3'd5: begin
				if(wr_data.in[5] != rd_data.out)
					begin
						`uvm_info(get_type_name(), "DATA MISMATCH", UVM_LOW)
						m_cfg.sb_mismatch++;
					end
				else
					begin
						`uvm_info(get_type_name(), "DATA MATCHED", UVM_LOW)
						m_cfg.sb_matched++;
					end
			end
			3'd6: begin
				if(wr_data.in[6] != rd_data.out)
					begin
						`uvm_info(get_type_name(), "DATA MISMATCH", UVM_LOW)
						m_cfg.sb_mismatch++;
					end
				else
					begin
						`uvm_info(get_type_name(), "DATA MATCHED", UVM_LOW)
						m_cfg.sb_matched++;
					end
			end
			default: begin
				if(wr_data.in[7] != rd_data.out)
						begin
							`uvm_info(get_type_name(), "DATA MISMATCH", UVM_LOW)
							m_cfg.sb_mismatch++;
						end
				else
					begin
						`uvm_info(get_type_name(), "DATA MATCHED", UVM_LOW)
						m_cfg.sb_matched++;
					end
			end
		endcase
	endfunction: compare

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(), $sformatf("\n\n----SCOREBOARD REPORT----\n\nData from wr_mon 	= %0d\nData from rd_mon 	= %0d\nData matched 		= %0d\nData mismatched		= %0d", m_cfg.sb_wr_mon, m_cfg.sb_rd_mon, m_cfg.sb_matched, m_cfg.sb_mismatch), UVM_LOW)
	endfunction: report_phase

endclass: mux_scoreboard







