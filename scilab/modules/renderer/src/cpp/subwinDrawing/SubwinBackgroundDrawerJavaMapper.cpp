/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2008 - INRIA - Jean-Baptiste Silvy
 * desc : Class containing java methods needed by BackTrihedronJoGL
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */


#include "SubwinBackgroundDrawerJavaMapper.hxx"

extern "C"
{
#include "getScilabJavaVM.h"
}

namespace sciGraphics
{

/*--------------------------------------------------------------------------*/
SubwinBackgroundDrawerJavaMapper::SubwinBackgroundDrawerJavaMapper(void)
{
  m_pJavaObject = new org_scilab_modules_renderer_subwinDrawing::SubwinBackgroundDrawerGL(getScilabJavaVM());
}
/*--------------------------------------------------------------------------*/
SubwinBackgroundDrawerJavaMapper::~SubwinBackgroundDrawerJavaMapper(void)
{
  delete m_pJavaObject;
  m_pJavaObject = NULL;
}
/*--------------------------------------------------------------------------*/
void SubwinBackgroundDrawerJavaMapper::display(void)
{
  m_pJavaObject->display();
}
/*--------------------------------------------------------------------------*/
void SubwinBackgroundDrawerJavaMapper::initializeDrawing(int figureIndex)
{
  m_pJavaObject->initializeDrawing(figureIndex);
}
/*--------------------------------------------------------------------------*/
void SubwinBackgroundDrawerJavaMapper::endDrawing(void)
{
  m_pJavaObject->endDrawing();
}
/*--------------------------------------------------------------------------*/
void SubwinBackgroundDrawerJavaMapper::show(int figureIndex)
{
  m_pJavaObject->show(figureIndex);
}
/*--------------------------------------------------------------------------*/
void SubwinBackgroundDrawerJavaMapper::destroy(int parentFigureIndex)
{
  m_pJavaObject->destroy(parentFigureIndex);
}
/*--------------------------------------------------------------------------*/
void SubwinBackgroundDrawerJavaMapper::setFigureIndex(int figureIndex)
{
  m_pJavaObject->setFigureIndex(figureIndex);
}
/*--------------------------------------------------------------------------*/
void SubwinBackgroundDrawerJavaMapper::setBoxParameters(int backgroundColor)
{
  m_pJavaObject->setBoxParameters(backgroundColor);
}
/*--------------------------------------------------------------------------*/
void SubwinBackgroundDrawerJavaMapper::drawBox(double xMin, double xMax, double yMin,
                                            double yMax, double zMin, double zMax,
                                            int concealedCornerIndex)
{
  m_pJavaObject->drawBox(xMin, xMax, yMin, yMax, zMin, zMax, concealedCornerIndex);
}
/*--------------------------------------------------------------------------*/
}