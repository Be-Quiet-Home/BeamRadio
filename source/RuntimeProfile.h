/*
 * Copyright 2026 Be-Quiet-Home contributors
 *
 * This file is part of BeamRadio and is distributed under the GNU GPL.
 */
#ifndef _RUNTIME_PROFILE_H
#define _RUNTIME_PROFILE_H


#include <Path.h>
#include <SupportDefs.h>


class RuntimeProfile {
public:
	static status_t ConfigureVictim(const char* path);
	static status_t SettingsDirectory(BPath& path);

	static bool IsVictim();
	static const char* ProfilePath();

private:
	static bool sVictim;
	static BPath sProfilePath;
};


#endif // _RUNTIME_PROFILE_H
