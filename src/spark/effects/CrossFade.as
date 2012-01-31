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
package spark.effects
{
	import flash.utils.ByteArray;
	
	/**
	 *  The CrossFade effect uses Pixel Bender, 
	 *  which is not supported for AIR mobile applications.
	 */
	[DiscouragedForProfile("mobileDevice")]
	
	/**
	 * The CrossFade effect performs a bitmap transition effect by running a
	 * <i>crossfade</i> between the first and second bitmaps.
	 * The crossfade blends the two bitmaps over the duration of the 
	 * animation.
	 *
	 * <p>At any point in the animation, where the 
	 * elapsed and eased fraction of the animation is <code>f</code> and the pixel
	 * values in the first and second bitmaps are <code>v1</code> and <code>v2</code>, 
	 * the resulting pixel value <code>v</code> for any pixel in the image is:</p>
	 *
	 * <pre>v = v1 &#42; (1 - f) + v2 &#42; f</pre>
	 * 
	 * <p>The bitmap effect is run by a pixel-shader program
	 * that is loaded by the effect. 
	 * You can specify a different crossfade behavior by specifying 
	 * a pixel-shader program to the <code>shaderByteCode</code> property.
	 * That pixel-shader program must meet the requirements defined in the 
	 * AnimateTransitionShader effect. </p>
	 * 
	 * @see spark.effects.AnimateTransitionShader
	 * @see spark.effects.AnimateTransitionShader#shaderByteCode
	 *
	 *  @includeExample examples/CrossFadeExample.mxml
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion Flex 4
	 */
	public class CrossFade extends AnimateTransitionShader
	{
		[Embed(source="CrossFade.pbj", mimeType="application/octet-stream")]
		private static var CrossFadeShaderClass:Class;
		private static var crossFadeShaderCode:ByteArray = new CrossFadeShaderClass();
		
		/**
		 *  Constructor. 
		 *
		 *  @param target The Object to animate with this effect.  
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function CrossFade(target:Object=null)
		{
			super(target);
			// Note that we do not need a separate CrossFadeInstance; the only
			// addition that CrossFade adds is specifying the Crossfade
			// Pixel Bender shader. Everything else needed is in the 
			// superclass already.
			shaderByteCode = crossFadeShaderCode;
		}
		
	}
}
