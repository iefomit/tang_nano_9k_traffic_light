BOARD=tangnano9k
FAMILY=GW1N-9C
DEVICE=GW1NR-LV9QN88PC6/I5
TOP=top

all: $(TOP).fs

$(TOP).json: top.v
	yosys -p "read_verilog top.v; synth_gowin -noalu -nolutram -top $(TOP) -json $(TOP).json"

$(TOP)_pnr.json: $(TOP).json
	nextpnr-gowin --json $(TOP).json --write $(TOP)_pnr.json --enable-auto-longwires --enable-globals --freq 27 --device $(DEVICE) --family $(FAMILY) --cst $(BOARD).cst

$(TOP).fs: $(TOP)_pnr.json
	gowin_pack -d $(FAMILY) -o $(TOP).fs $(TOP)_pnr.json

load: $(TOP).fs
	openFPGALoader -b $(BOARD) $(TOP).fs -f

clean:
	rm -f $(TOP).json $(TOP)_pnr.json $(TOP).fs

.PHONY: all load clean
.INTERMEDIATE: $(TOP).json $(TOP)_pnr.json
