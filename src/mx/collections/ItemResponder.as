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

package mx.collections
{
	
	import mx.rpc.IResponder;
	
	
	/**
	 *  The ItemResponder class provides a default implementation of the
	 *  <code>mx.rpc.IResponder</code> interface.
	 *  It represents a responder that lets you specify methods to be 
	 *  called when a request is completed, either successfully or with an error.
	 *  The class object can also lets you provide data (a token) to be used by
	 *  the responder methods.
	 * 
	 * <p>You use an <code>ItemResponder</code> object in the <code>catch</code> statement
	 * of a try block that might result in getting remote data, as shown in the following
	 * code:</p>
	 * 
	 *  <pre><code>
	 *     import mx.collections.ItemResponder;
	 *     //...
	 *
	 *     try
	 *     {
	 *        //...
	 *        cursor.moveNext();
	 *     }
	 *	   catch(e:ItemPendingError)
	 *     {
	 *        e.addResponder(new ItemResponder(myResultFunction, myFaultFunction, {info:"..."}));
	 *     }
	 *  </code></pre>
	 *
	 *  <p>The result method specified must have the following signature:</p>
	 * 
	 *  <code><pre>
	 *     public function myResultFunction(result:Object, token:Object = null):void;
	 *  </pre></code>
	 *
	 *  <p>The fault method specified must have the following signature:</p>
	 * 
	 *  <code><pre>
	 *     public function myFaultFunction(error:Object, token:Object = null):void;
	 *  </pre></code>
	 * 
	 *  <p>Any other signature will result in a runtime error.</p>
	 * 
	 *  @see mx.collections.errors.ItemPendingError
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 9
	 *  @playerversion AIR 1.1
	 *  @productversion Flex 3
	 */
	public class ItemResponder implements IResponder
	{
		include "../core/Version.as";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructs an instance of the responder with the specified data and 
		 *  handlers.
		 *  
		 *  @param	result Function that should be called when the request has
		 *          completed successfully.
		 *  		Must have the following signature:
		 *  		<code><pre>
		 *     		    public function (result:Object, token:Object = null):void;
		 *  		</pre></code>
		 *  @param	fault Function that should be called when the request has
		 *			completed with errors.
		 *  		Must have the following signature:
		 *  		<code><pre>
		 *     		    public function (error:ErrorMessage, token:Object = null):void;
		 *  		</pre></code>
		 *  @param	token Object [optional] additional information to associate with
		 *          this request. This object is passed to the result and fault functions
		 *          as their second parameter.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function ItemResponder(result:Function, fault:Function, token:Object = null)
		{
			super();
			
			_resultHandler = result;
			_faultHandler = fault;
			_token = token;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  This method is called by a service when the return value has been 
		 *  received.
		 *
		 *  @param	data Object containing the information returned from the request.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function result(data:Object):void
		{
			_resultHandler(data, _token);
		}
		
		/**
		 *  This method is called by a service when an error has been received.
		 *
		 *  @param	info Object containing the information about the error that 
		 *   		occured.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function fault(info:Object):void
		{
			_faultHandler(info, _token);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		private var _resultHandler:Function;
		private var _faultHandler:Function;
		private var _token:Object;
	}
	
	
}