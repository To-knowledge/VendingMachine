transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/VendingMachine2.0 {E:/VendingMachine2.0/VendingMachine.v}
vlog -vlog01compat -work work +incdir+E:/VendingMachine2.0 {E:/VendingMachine2.0/price_product.v}
vlog -vlog01compat -work work +incdir+E:/VendingMachine2.0 {E:/VendingMachine2.0/processing.v}
vlog -vlog01compat -work work +incdir+E:/VendingMachine2.0 {E:/VendingMachine2.0/change.v}
vlog -vlog01compat -work work +incdir+E:/VendingMachine2.0 {E:/VendingMachine2.0/putting_money.v}

