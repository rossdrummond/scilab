// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO - Pierre MARECHAL <pierre.marechal@scilab.org>
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// get the list of repositories

function repositories = atomsRepositoryList(level)
	
	// Load Atoms Internals lib if it's not already loaded
	// =========================================================================
	if ~ exists("atomsinternalslib") then
		load("SCI/modules/atoms/macros/atoms_internals/lib");
	end
	
	rhs           = argn(2);
	repositories  = [];
	
	// Check number of input arguments
	// =========================================================================
	
	if rhs > 1 then
		error(msprintf(gettext("%s: Wrong number of input argument: %d to %d expected.\n"),"atomsRepositoryList",0,1));
	end
	
	// Check input argument type (if any)
	// =========================================================================
	
	if (rhs==1) & (type(level) <> 10) then
		error(msprintf(gettext("%s: Wrong type for input argument #%d: Single string expected.\n"),"atomsRepositoryList",1));
	end
	
	// Check input argument dimension (if any)
	// =========================================================================
	
	if (rhs==1) & (size(level,"*")<>1) then
		error(msprintf(gettext("%s: Wrong size for input argument #%d: Single string expected.\n"),"atomsRepositoryList",1));
	end
	
	// Check input argument values (if any)
	// =========================================================================
	
	if (rhs==1) & (and(level<>["user","allusers","official"])) then
		error(msprintf(gettext("%s: Wrong value for input argument #%d: ''user'',''allusers'' or ''official'' expected.\n"),"atomsRepositoryList",1));
	end
	
	// Define the needed paths
	// =========================================================================
	
	official_repositories = pathconvert(SCI+"/modules/atoms/etc/repositories",%F);
	allusers_repositories = pathconvert(SCI+"/.atoms/repositories",%F);
	user_repositories     = pathconvert(SCIHOME+"/atoms/repositories",%F);
	
	// official repositories
	// =========================================================================
	
	if (rhs == 0) | ((rhs == 1) & (level == "official")) then
		if fileinfo(official_repositories) <> [] then
			url_list = mgetl(official_repositories);
			for i=1:size(url_list,"*")
				repositories = [ repositories ; url_list(i)  "official" ];
			end
		end
	end
	
	// All users repositories
	// =========================================================================
	
	if (rhs == 0) | ((rhs == 1) & (level == "allusers")) then
		if fileinfo(allusers_repositories) <> [] then
			url_list = mgetl(allusers_repositories);
			for i=1:size(url_list,"*")
				repositories = [ repositories ; url_list(i)  "allusers" ];
			end
		end
	end
	
	// User repositories
	// =========================================================================
	
	if (rhs == 0) | ((rhs == 1) & (level == "user")) then
		if fileinfo(user_repositories) <> [] then
			url_list = mgetl(user_repositories);
			for i=1:size(url_list,"*")
				repositories = [ repositories ; url_list(i)  "user" ];
			end
		end
	end
	
endfunction