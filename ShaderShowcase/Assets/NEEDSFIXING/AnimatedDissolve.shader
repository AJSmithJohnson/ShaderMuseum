Shader "ClipShaders/AnimatedDissolve"
{
	//We declare our properties block
	Properties
	{
		//We create a color value
		_Color("Our mesh color", Color) = (1,1,1,1)
		//WE create a value for our main texture
		_MainTexture("Our Main Texture", 2D) = "white" {}
		//We create a value for our dissolve texture
		_DissolveTexture("Dissolve Texture", 2D) = "white" {}
		//WE create a value for the dissolv amount
		_Amount("The amount of dissolve applied", Range(0, 1)) = 0.1
		//The speed of the sin time animation
		_Speed("The speed of sin animation", Range(0, 100)) = 5
	}//End of properties block

		SubShader
		{
			Tags{ "RenderType" = "Opaque" } //The RenderType is set to Opaque this is mostly done so that if we decide to create replacement shaders later we can replace a specific shader
			Cull Off //We set culling to off so all faces are drawn

			CGPROGRAM//We start writing cg
	#pragma surface surf Standard fullfowardshadows //we are writing a surface shader with a function named surf that is using the standard unity lighting model
				//fullfoward shadows indicates we want to support all light shadow types in the foward rendering path 
	#pragma target 3.0//We specify our Shader compilation target

				//We redefine all of our variables in our shader code
				fixed4 _Color;
				sampler2D _MainTexture;
				sampler2D _DissolveTexture;
				half _Amount;
				half _Speed;
				//We create our input struct to get info from our model
				struct Input
				{
					//We only want our models Uv's
					float2 uv_MainTexture;
					////IMPORTANT NOTE IF THIS IS NOT THE SAME NAME AS ONE OF YOUR TEXTURES ABOVE YOU WILL GET SOME ERRORS KEEP THIS IN MIND
				};

				//Finally we create our Surf function
				//We pass in our input struct 
				//And our lighting info as parameters
				void surf(Input IN, inout SurfaceOutputStandard o)
				{
					//We get the dissolve amount by passing our textures rgb values into a half called _dissolveAmount
					half _dissolveAmount = tex2D(_DissolveTexture, IN.uv_MainTexture).rgb;
					
					//_dissolve amount is multiplied by the built in time function to animate it //This features is not working right now 
					//_dissolveAmount += _Time * _Speed;
					//We clip by subtracting from _dissolve amount by _Amount
					clip(_dissolveAmount - _Amount);

					//To get an outline to our clip amount we can say
					if (_dissolveAmount - _Amount < 0.05f)
						o.Emission = fixed3(0, 0, 1);

					//This is just standard code to get color
					float4 c = tex2D(_MainTexture, IN.uv_MainTexture) * _Color;
					o.Albedo = c.rgb;
					o.Alpha = c.a;
				}
				


		ENDCG//We stop writing cg
	}
}