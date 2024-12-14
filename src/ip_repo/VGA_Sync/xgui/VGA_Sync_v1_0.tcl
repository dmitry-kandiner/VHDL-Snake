# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Settings}]
  #Adding Group
  set Horizontal [ipgui::add_group $IPINST -name "Horizontal" -parent ${Page_0}]
  set h_active [ipgui::add_param $IPINST -name "h_active" -parent ${Horizontal}]
  set_property tooltip {Horizontal resolution, pixels} ${h_active}
  set h_sync_pulse [ipgui::add_param $IPINST -name "h_sync_pulse" -parent ${Horizontal}]
  set_property tooltip {Horizontal sync pulse width, pixels} ${h_sync_pulse}
  ipgui::add_param $IPINST -name "h_sync_neg" -parent ${Horizontal}
  set h_front_porch [ipgui::add_param $IPINST -name "h_front_porch" -parent ${Horizontal}]
  set_property tooltip {Horizontal front porch, pixels} ${h_front_porch}
  set h_back_porch [ipgui::add_param $IPINST -name "h_back_porch" -parent ${Horizontal}]
  set_property tooltip {Horizontal back porch, pixels} ${h_back_porch}

  #Adding Group
  set Vertical [ipgui::add_group $IPINST -name "Vertical" -parent ${Page_0}]
  set v_active [ipgui::add_param $IPINST -name "v_active" -parent ${Vertical}]
  set_property tooltip {Vertical resolution, lines} ${v_active}
  set v_back_porch [ipgui::add_param $IPINST -name "v_back_porch" -parent ${Vertical}]
  set_property tooltip {Horizontal back porch, lines} ${v_back_porch}
  set v_sync_pulse [ipgui::add_param $IPINST -name "v_sync_pulse" -parent ${Vertical}]
  set_property tooltip {Vertical sync pulse width, lines} ${v_sync_pulse}
  ipgui::add_param $IPINST -name "v_sync_neg" -parent ${Vertical}
  set v_front_porch [ipgui::add_param $IPINST -name "v_front_porch" -parent ${Vertical}]
  set_property tooltip {Vertical front porch, lines} ${v_front_porch}

  ipgui::add_static_text $IPINST -name "Info" -parent ${Page_0} -text {The default settings correspond to VGA mode 640x480@73Hz, with pixe clock of 31.5MHz, vsync-, hsync-}


}

proc update_PARAM_VALUE.h_active { PARAM_VALUE.h_active } {
	# Procedure called to update h_active when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.h_active { PARAM_VALUE.h_active } {
	# Procedure called to validate h_active
	return true
}

proc update_PARAM_VALUE.h_back_porch { PARAM_VALUE.h_back_porch } {
	# Procedure called to update h_back_porch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.h_back_porch { PARAM_VALUE.h_back_porch } {
	# Procedure called to validate h_back_porch
	return true
}

proc update_PARAM_VALUE.h_front_porch { PARAM_VALUE.h_front_porch } {
	# Procedure called to update h_front_porch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.h_front_porch { PARAM_VALUE.h_front_porch } {
	# Procedure called to validate h_front_porch
	return true
}

proc update_PARAM_VALUE.h_sync_neg { PARAM_VALUE.h_sync_neg } {
	# Procedure called to update h_sync_neg when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.h_sync_neg { PARAM_VALUE.h_sync_neg } {
	# Procedure called to validate h_sync_neg
	return true
}

proc update_PARAM_VALUE.h_sync_pulse { PARAM_VALUE.h_sync_pulse } {
	# Procedure called to update h_sync_pulse when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.h_sync_pulse { PARAM_VALUE.h_sync_pulse } {
	# Procedure called to validate h_sync_pulse
	return true
}

proc update_PARAM_VALUE.v_active { PARAM_VALUE.v_active } {
	# Procedure called to update v_active when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.v_active { PARAM_VALUE.v_active } {
	# Procedure called to validate v_active
	return true
}

proc update_PARAM_VALUE.v_back_porch { PARAM_VALUE.v_back_porch } {
	# Procedure called to update v_back_porch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.v_back_porch { PARAM_VALUE.v_back_porch } {
	# Procedure called to validate v_back_porch
	return true
}

proc update_PARAM_VALUE.v_front_porch { PARAM_VALUE.v_front_porch } {
	# Procedure called to update v_front_porch when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.v_front_porch { PARAM_VALUE.v_front_porch } {
	# Procedure called to validate v_front_porch
	return true
}

proc update_PARAM_VALUE.v_sync_neg { PARAM_VALUE.v_sync_neg } {
	# Procedure called to update v_sync_neg when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.v_sync_neg { PARAM_VALUE.v_sync_neg } {
	# Procedure called to validate v_sync_neg
	return true
}

proc update_PARAM_VALUE.v_sync_pulse { PARAM_VALUE.v_sync_pulse } {
	# Procedure called to update v_sync_pulse when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.v_sync_pulse { PARAM_VALUE.v_sync_pulse } {
	# Procedure called to validate v_sync_pulse
	return true
}


proc update_MODELPARAM_VALUE.h_sync_pulse { MODELPARAM_VALUE.h_sync_pulse PARAM_VALUE.h_sync_pulse } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.h_sync_pulse}] ${MODELPARAM_VALUE.h_sync_pulse}
}

proc update_MODELPARAM_VALUE.h_sync_neg { MODELPARAM_VALUE.h_sync_neg PARAM_VALUE.h_sync_neg } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.h_sync_neg}] ${MODELPARAM_VALUE.h_sync_neg}
}

proc update_MODELPARAM_VALUE.h_front_porch { MODELPARAM_VALUE.h_front_porch PARAM_VALUE.h_front_porch } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.h_front_porch}] ${MODELPARAM_VALUE.h_front_porch}
}

proc update_MODELPARAM_VALUE.h_active { MODELPARAM_VALUE.h_active PARAM_VALUE.h_active } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.h_active}] ${MODELPARAM_VALUE.h_active}
}

proc update_MODELPARAM_VALUE.h_back_porch { MODELPARAM_VALUE.h_back_porch PARAM_VALUE.h_back_porch } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.h_back_porch}] ${MODELPARAM_VALUE.h_back_porch}
}

proc update_MODELPARAM_VALUE.v_sync_pulse { MODELPARAM_VALUE.v_sync_pulse PARAM_VALUE.v_sync_pulse } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.v_sync_pulse}] ${MODELPARAM_VALUE.v_sync_pulse}
}

proc update_MODELPARAM_VALUE.v_sync_neg { MODELPARAM_VALUE.v_sync_neg PARAM_VALUE.v_sync_neg } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.v_sync_neg}] ${MODELPARAM_VALUE.v_sync_neg}
}

proc update_MODELPARAM_VALUE.v_front_porch { MODELPARAM_VALUE.v_front_porch PARAM_VALUE.v_front_porch } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.v_front_porch}] ${MODELPARAM_VALUE.v_front_porch}
}

proc update_MODELPARAM_VALUE.v_active { MODELPARAM_VALUE.v_active PARAM_VALUE.v_active } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.v_active}] ${MODELPARAM_VALUE.v_active}
}

proc update_MODELPARAM_VALUE.v_back_porch { MODELPARAM_VALUE.v_back_porch PARAM_VALUE.v_back_porch } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.v_back_porch}] ${MODELPARAM_VALUE.v_back_porch}
}

