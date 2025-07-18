class mux_test extends uvm_test;

	`uvm_component_utils(mux_test)

	// Sub-component handles
	mux_env 	envh;
	mux_config 	m_cfg;

	function new(string name="mux_test", uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		// Config creation
		m_cfg = mux_config::type_id::create("m_cfg");

		// Getting the vif from top
		if(!uvm_config_db#(virtual mux_intf)::get(this, "", "vif", m_cfg.vif))
			`uvm_fatal(get_type_name(), "FAILED TO GET")

		// Setting config object
		uvm_config_db#(mux_config)::set(this, "*", "mux_config", m_cfg);

		// Creating env
		envh = mux_env::type_id::create("envh", this);
	endfunction: build_phase

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);

		// Printing the topology
		uvm_top.print_topology();
	endfunction: end_of_elaboration_phase

	mux_wr_seqs seqh;

	// Base sequence test run_phase
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		
		phase.raise_objection(this);
		
		seqh = mux_wr_seqs::type_id::create("seqh");
		seqh.start(envh.wr_agnth.seqrh);
		#15;

		phase.drop_objection(this);	

	endtask: run_phase

endclass: mux_test

// Extended test to run all_seqs
class all_test extends mux_test;

	`uvm_component_utils(all_test)

	function new(string name="all_test", uvm_component parent);
		super.new(name, parent);
	endfunction: new

	all_test_seqs seqs;

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);

		seqs = all_test_seqs::type_id::create("seqs");
		seqs.start(envh.wr_agnth.seqrh);
		#15;

		phase.drop_objection(this);
	endtask: run_phase

endclass: all_test
