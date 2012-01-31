////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package spark.accessibility
{
	
	import flash.accessibility.Accessibility;
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import mx.accessibility.AccConst;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	
	import spark.components.NumericStepper;
	import spark.components.TextInput;
	import spark.events.SkinPartEvent;
	
	use namespace mx_internal;
	
	/**
	 *  NumericStepperAccImpl is the accessibility implementation class
	 *  for spark.components.NumericStepper.
	 *
	 *  <p>When a Spark NumericStepper is created,
	 *  its <code>accessibilityImplementation</code> property
	 *  is set to an instance of this class.
	 *  The Flash Player then uses this class to allow MSAA clients
	 *  such as screen readers to see and manipulate the NumericStepper.
	 *  See the mx.accessibility.AccImpl and
	 *  flash.accessibility.AccessibilityImplementation classes
	 *  for background information about accessibility implementation
	 *  classes and MSAA.</p>
	 *
	 *  <p><b>Children</b></p>
	 *
	 *  <p>A NumericStepper has two MSAA children,
	 *  which are its increment and decrement buttons.</p>
	 *
	 *  <p><b>Role</b></p>
	 *
	 *  <p>The MSAA Role of a NumericStepper is ROLE_SYSTEM_TEXT.</p>
	 *
	 *  <p>The Role of each child button is ROLE_SYSTEM_PUSHBUTTON.</p>
	 *
	 *  <p><b>Name</b></p>
	 *
	 *  <p>The MSAA Name of a NumericStepper is, by default, an empty string.
	 *  When wrapped in a FormItem element, the Name is the FormItem's label.
	 *  To override this behavior,
	 *  set the NumericStepper's <code>accessibilityName</code> property.</p>
	 *
	 *  <p>The Name of each child button comes from a locale-dependent resource.
	 *  For the en_US locale, the names are "More" and "Less".</p>
	 *
	 *  <p>When the Name of the NumericStepper or one of its child button changes
	 *  a NumericStepper dispatches the MSAA event EVENT_OBJECT_NAMECHANGE
	 *  with the proper childID for the button or 0 for itself.</p>
	 *
	 *  <p><b>Description</b></p>
	 *
	 *  <p>The MSAA Description of a NumericStepper is, by default, an empty string,
	 *  but you can set the NumericStepper's <code>accessibilityDescription</code>
	 *  property.</p>
	 *
	 *  <p>The Description of each child button is the empty string.</p>
	 *
	 *  <p><b>State</b></p>
	 *
	 *  <p>The MSAA State of a NumericStepper is a combination of:
	 *  <ul>
	 *    <li>STATE_SYSTEM_UNAVAILABLE (when enabled is false)</li>
	 *    <li>STATE_SYSTEM_FOCUSABLE (when enabled is true)</li>
	 *    <li>STATE_SYSTEM_FOCUSED
	 *    (when enabled is true and the Spinner has focus)</li>
	 *  </ul></p>
	 *
	 *  <p>When the State of the NumericStepper or one of its child buttons changes,
	 *  a NumericStepper dispatches the MSAA event EVENT_OBJECT_STATECHANGE
	 *  with the proper childID for the button or 0 for itself.</p>
	 *
	 *  <p><b>Value</b></p>
	 *
	 *  <p>The MSAA Value of a NumericStepper is the value
	 *  currently held by the NumericStepper.</p>
	 *
	 *  <p>The child buttons do not have MSAA values.</p>
	 *
	 *  <p>When the Value of the NumericStepper changes,
	 *  the NumericStepper dispatches the MSAA event EVENT_OBJECT_VALUECHANGE.</p>
	 *
	 *  <p><b>Location</b></p>
	 *
	 *  <p>The MSAA Location of a NumericStepper, or one of its child buttons,
	 *  is its bounding rectangle.</p>
	 *
	 *  <p><b>Default Action</b></p>
	 *
	 *  <p>A NumericStepper does not have an MSAA DefaultAction.</p>
	 *
	 *  <p>The DefaultAction of each child button is "Press".</p>
	 *
	 *  <p>Performing the default action of one of the child buttons
	 *  will increment or decrement the value.</p>
	 *
	 *  <p><b>Focus</b></p>
	 *
	 *  <p>A NumericStepper accepts focus.
	 *  When it does so, it dispatches the MSAA event EVENT_OBJECT_FOCUS.</p>
	 *
	 *  <p><b>Selection</b></p>
	 *
	 *  <p>A NumericStepper does not support selection in the MSAA sense.</p>
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public class NumericStepperAccImpl extends SpinnerAccImpl
	{
		include "../core/Version.as";
		
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Enables accessibility in the Spinner class.
		 *
		 *  <p>This method is called by application startup code
		 *  that is autogenerated by the MXML compiler.
		 *  Afterwards, when instances of Spinner are initialized,
		 *  their <code>accessibilityImplementation</code> property
		 *  will be set to an instance of this class.</p>
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public static function enableAccessibility():void
		{
			NumericStepper.createAccessibilityImplementation = 
				createAccessibilityImplementation;
		}
		
		/**
		 *  @private
		 *  Creates a Spinner's AccessibilityImplementation object.
		 *  This method is called from UIComponent's
		 *  initializeAccessibility() method.
		 */
		mx_internal static function createAccessibilityImplementation(
			component:UIComponent):void
		{
			component.accessibilityImplementation =
				new NumericStepperAccImpl(component);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor.
		 *
		 *  @param master The UIComponent instance that this AccImpl instance
		 *  is making accessible.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function NumericStepperAccImpl(master:UIComponent)
		{
			super(master);
			
			role = AccConst.ROLE_SYSTEM_TEXT;
			
			// NumericStepper has a TextInput as a skin part,
			// and we need to listen to some of its events.
			// It may or may not be present when this constructor is called.
			// If it comes or goes later, we are notified via
			// "partAdded" and "partRemoved" events.
			var textDisplay:TextInput = NumericStepper(master).textDisplay;
			if (textDisplay)
			{
				textDisplay.addEventListener(Event.CHANGE, eventHandler);        
				textDisplay.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden properties: AccImpl
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  eventsToHandle
		//----------------------------------
		
		/**
		 *  @private
		 *  Array of events that we should listen for from the master component.
		 */
		override protected function get eventsToHandle():Array
		{
			return super.eventsToHandle.concat([ SkinPartEvent.PART_ADDED,
				SkinPartEvent.PART_REMOVED ]);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden event handlers: AccImpl
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 *  Override the generic event handler.
		 *  All AccImpl must implement this
		 *  to listen for events from its master component.
		 */
		override protected function eventHandler(event:Event):void
		{
			var textDisplay:TextInput;
			
			switch (event.type)
			{
				case SkinPartEvent.PART_ADDED:
				{
					textDisplay = NumericStepper(master).textDisplay;
					if (SkinPartEvent(event).instance == textDisplay)
					{
						textDisplay.addEventListener(Event.CHANGE,
							eventHandler);        
						textDisplay.addEventListener(FocusEvent.FOCUS_IN,
							focusInHandler);
					}
					break;
				}
					
				case SkinPartEvent.PART_REMOVED:
				{
					textDisplay = NumericStepper(master).textDisplay;
					if (SkinPartEvent(event).instance == textDisplay)
					{
						textDisplay.removeEventListener(Event.CHANGE,
							eventHandler);        
						textDisplay.removeEventListener(FocusEvent.FOCUS_IN,
							focusInHandler);
					}
					break;
				}
					
				default:
				{
					super.eventHandler(event);
				}
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		private function focusInHandler(event:Event):void
		{
			Accessibility.sendEvent(master, 0, AccConst.EVENT_OBJECT_FOCUS);
		}
	}
	
}
