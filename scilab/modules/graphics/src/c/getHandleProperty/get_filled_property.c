/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2008 - INRIA - Jean-Baptiste Silvy
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

/*------------------------------------------------------------------------*/
/* file: get_filled_property.c                                            */
/* desc : function to retrieve in Scilab the filled field of a            */
/*        handle                                                          */
/*------------------------------------------------------------------------*/

#include "getHandleProperty.h"
#include "GetProperty.h"
#include "returnProperty.h"
#include "sciprint.h"
#include "localization.h"

/*------------------------------------------------------------------------*/
int get_filled_property( sciPointObj * pobj )
{

  if (sciGetEntityType(pobj) != SCI_SUBWIN)
  {
    sciprint(_("%s property undefined for this object.\n"), "filled") ;
    return -1;
  }

  if ( sciGetIsFilled( pobj ) )
  {
    return sciReturnString( "on" ) ;
  }
  else
  {
    return sciReturnString( "off" ) ;
  }
}
/*------------------------------------------------------------------------*/