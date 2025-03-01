.PHONY: live 

clean:
	sudo lb clean

live: 
	lb config -d bookworm --debian-installer live --debian-installer-distribution bookworm --archive-areas "main non-free-firmware" --debootstrap-options "--variant=minbase" --bootappend-live "boot=live components locales=pt_PT.UTF-8 keyboard-layouts=pt"
	sudo lb build
