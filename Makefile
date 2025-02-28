.PHONY: live

clean:
	sudo lb clean

live:
	lb config -d bookworm --debian-installer live --debian-installer-distribution bookworm --archive-areas "main non-free-firmware" --debootstrap-options "--variant=minbase"
	sudo lb build
