// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO - Pierre MARECHAL <pierre.marechal@scilab.org>
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

// Show information on a package

function atomsShow(name,version)
	
	// Load Atoms Internals lib if it's not already loaded
	// =========================================================================
	if ~ exists("atomsinternalslib") then
		load("SCI/modules/atoms/macros/atoms_internals/lib");
	end
	
	rhs = argn(2);
	
	// Check number of input arguments
	// =========================================================================
	
	if rhs < 1 | rhs > 2 then
		error(msprintf(gettext("%s: Wrong number of input argument: %d to %d expected.\n"),"atomsShow",1,2));
	end
	
	// Check input parameters type
	// =========================================================================
	
	if type(name) <> 10 then
		error(msprintf(gettext("%s: Wrong type for input argument #%d: A single string expected.\n"),"atomsShow",1));
	end
	
	if (rhs>1) & (type(version)<>10)  then
		error(msprintf(gettext("%s: Wrong type for input argument #%d: A single string expected.\n"),"atomsShow",2));
	end
	
	// Check input parameters dimensions
	// =========================================================================
	
	if size(name,"*") <> 1 then
		error(msprintf(gettext("%s: Wrong size for input argument #%d: A single string expected.\n"),"atomsShow",1));
	end
	
	if (rhs>1) & (size(version,"*") <> 1) then
		error(msprintf(gettext("%s: Wrong size for input argument #%d: A single string expected.\n"),"atomsShow",2));
	end
	
	
	// If version is not defined, the Most Recent Version is used
	// =========================================================================
	if rhs<2 then
		version = atomsGetMRVersion(name);
	end
	
	// Get the details of this package
	// =========================================================================
	
	details = atomsToolboxDetails(name,version);
	
	fields_map = [];
	fields_map = [ fields_map ; "Toolbox"        gettext("Package")        ];
	fields_map = [ fields_map ; "Title"          gettext("Title")          ];
	fields_map = [ fields_map ; "Summary"        gettext("Summary")        ];
	fields_map = [ fields_map ; "Version"        gettext("Version")        ];
	fields_map = [ fields_map ; "Depends"        gettext("Depend")         ];
	fields_map = [ fields_map ; "Category"       gettext("Category(ies)")  ];
	fields_map = [ fields_map ; "Maintainer"     gettext("Maintainer(s)")  ];
	fields_map = [ fields_map ; "Entity"         gettext("Entity")         ];
	fields_map = [ fields_map ; "WebSite"        gettext("WebSite")        ];
	fields_map = [ fields_map ; "License"        gettext("License")        ];
	fields_map = [ fields_map ; "ScilabVersion"  gettext("Scilab Version") ];
	
	fields_map = [ fields_map ; "Status"         gettext("Status")         ];
	
	if atomsIsInstalled(name,version) then
		fields_map = [ fields_map ; "InstallAutomaticaly" gettext("Automaticaly Installed")];
		fields_map = [ fields_map ; "installPath"         gettext("Install Directory")];
	end
	
	fields_map = [ fields_map ; "Description"    gettext("Description")    ];
	
	// Show it
	// =========================================================================
	
	max_field_len = max( length(fields_map(:,2)) );
	
	for i=1:size(fields_map(:,1),"*")
		
		value = "";
		
		//
		// Status
		// 
		
		if fields_map(i,1)=="Status" then
			if atomsIsInstalled(name,version) then
				value = "Installed";
			else
				value = "Not installed";
			end
		end
		
		//
		// Automaticaly Installed ?
		// 
		
		if fields_map(i,1)=="InstallAutomaticaly" then
			if atomsGetInstalledStatus(name,version) == "A" then
				value = "yes";
			else
				value = "no";
			end
		end
		
		//
		// Scilab Version
		// 
		
		if fields_map(i,1)=="ScilabVersion" then
			if regexp( details(fields_map(i,1)) , "/^~/" , "o" )<>[] then
				value = "any";
			else
				value = details(fields_map(i,1));
			end
		end
		
		//
		// Dependences
		// 
		
		if fields_map(i,1)=="Depends" then
			value = dep2str(details(fields_map(i,1)));
		end
		
		//
		// Other
		//
		
		if isempty(value) then
			value = details(fields_map(i,1));
		end
		
		for j=1:size(value,"*")
			
			if j==1 then
				mprintf("% "+string(max_field_len)+"s : %s\n",fields_map(i,2),value(j))
				
			else
				mprintf("% "+string(max_field_len)+"s   %s\n","",value(j))
			end
		end
	end
	
endfunction

// =============================================================================
// string = dep2str(string)
//
// Convert a technical dependence string (For ex. : ">= toolbox_1 1.3") to a
// display dependence string  (For ex. : "toolbox_1 (>= 1.3)" )
// 
// =============================================================================

function str = dep2str(dep)
	
	str = [];
	
	if isempty(dep) then
		return;
	end
	
	for i=1:size(dep,"*")
		
		this_dep = dep(i);
		
		// direction part
		this_dep         = stripblanks(this_dep);
		direction_length = regexp(this_dep,"/\s/","o");
		direction        = stripblanks(part(this_dep,1:direction_length-1));
		
		// name part 
		this_dep         = stripblanks(part(this_dep,direction_length+1:length(this_dep)));
		name_length      = regexp(this_dep,"/\s/","o");
		name             = part(this_dep,1:name_length-1);
		
		// version part
		version          = stripblanks(part(this_dep,name_length:length(this_dep)));
		
		this_str         = name+" ";
		
		if direction == "~" then
			this_str = this_str + "(Any version)";
		else
			this_str = this_str + "("+direction+" "+version+")";
		end
		
		str = [ str ; this_str ];
		
	end
	
endfunction