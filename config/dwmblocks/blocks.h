//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "~/scripts/bb/weather.clj dwm", 360,	0},
	{"", "~/scripts/legacy-xorg-dwm/dwm-volume.sh", 10,	0},
	{"", "~/scripts/waybar.clj load", 10,	0},
	{"", "~/scripts/legacy-xorg-dwm/dwm_disk_space.clj", 10,	0},
	{"", "~/scripts/legacy-xorg-dwm/dwm_memory.clj", 10,	0},
	{"", "~/scripts/legacy-xorg-dwm/vpn2.clj", 10,	0},
	{"", "~/scripts/legacy-xorg-dwm/dwm-date.sh", 1,	0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
