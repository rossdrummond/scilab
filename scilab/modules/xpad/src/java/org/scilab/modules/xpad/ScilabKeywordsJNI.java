/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 1.3.35
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package org.scilab.modules.xpad;


 /** 
   * @author Allan CORNET
   * @copyright DIGITEO 2009
   */
public class ScilabKeywordsJNI {

  /**
    * Constructor
    */
  protected ScilabKeywordsJNI() {
	throw new UnsupportedOperationException();
  }

  private static final String OSNAME = System.getProperty("os.name").toLowerCase();
  static {
    try {
        if (OSNAME.indexOf("windows") != -1) {
        System.loadLibrary("xpad");
        }
        else {
        System.loadLibrary("scixpad");
        }
    } catch (SecurityException e) {
		System.err.println("A security manager exists and does not allow the loading of the specified dynamic library :");
		e.printStackTrace(System.err);
	} catch (UnsatisfiedLinkError e)	{
		System.err.println("The native library xpad does not exist or cannot be found.");
		e.printStackTrace(System.err);
    }
  }

  public final static native String[] GetVariablesName();
  public final static native String[] GetCommandsName();
  public final static native String[] GetFunctionsName();
  public final static native String[] GetMacrosName();
}