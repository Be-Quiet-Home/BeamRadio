/*
 * Copyright 2026 Be-Quiet-Home contributors
 *
 * This file is part of BeamRadio and is distributed under the GNU GPL.
 */


#include "RuntimeProfile.h"

#include <Directory.h>
#include <Errors.h>
#include <FindDirectory.h>


const char* kVictimProfileMarker = ".beamradio-victim-profile";

bool RuntimeProfile::sVictim = false;
BPath RuntimeProfile::sProfilePath;


status_t
RuntimeProfile::ConfigureVictim(const char* path)
{
	if (path == NULL || path[0] != '/')
		return B_BAD_VALUE;

	BPath profilePath;
	status_t status = profilePath.SetTo(path);
	if (status != B_OK)
		return status;

	BDirectory profileDirectory(profilePath.Path());
	status = profileDirectory.InitCheck();
	if (status != B_OK)
		return status;

	if (!profileDirectory.Contains(kVictimProfileMarker, B_FILE_NODE))
		return B_NOT_ALLOWED;

	sProfilePath = profilePath;
	sVictim = true;
	return B_OK;
}


status_t
RuntimeProfile::SettingsDirectory(BPath& path)
{
	if (sVictim)
		return path.SetTo(sProfilePath.Path());

	if (find_directory(B_USER_SETTINGS_DIRECTORY, &path) != B_OK)
		return path.SetTo("/boot/home/config/settings");

	return B_OK;
}


bool
RuntimeProfile::IsVictim()
{
	return sVictim;
}


const char*
RuntimeProfile::ProfilePath()
{
	return sVictim ? sProfilePath.Path() : "";
}
