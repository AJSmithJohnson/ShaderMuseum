Shader "CubeMapShaders/BasicCubeMap"
{
	Properties//Inspector properties
	{
		_myDiffuse("Diffuse map", 2D) = "white" {} //We have a diffuse map that is a 2D texture and is set to white
		_myBump("normal map", 2D) = "white" {} //A normal map that is a 2D texture and is set to white for a default value
		_mySlider("Bump amount", Range(0,10)) = 1 // A slider for a bump map amount that is set to  1 and ranges from 0 to 10
		_myBright("Brightness amount", Range(0, 10)) = 1//A slider for brightness amount that is set to 1 and ranges from 0 to 10
		_myCube("My cube map", CUBE) = "white"{} // A cube map for environmental reflections that is set to white and is a CUBE datatype meaning
		//It has 6 faces

	}
	SubShader //the beginning of our subshader block
	{
		CGPROGRAM //The beginning of our CG code
			#pragma surface surf Lambert //Our pragma function is a surface shader with a method named surf that is 
			//using the Lambert lighting model
			

			//We redeclare all of our values down here
			sampler2D _myDiffuse; //our diffuse map is a sampler2D datatype
			sampler2D _myBump; //Our bump map is also a sampler2D datatype
			half _mySlider;	//our slider is a half datatype
			half _myBright; //our bright is the same datatype as our slider
			samplerCUBE _myCube; //our cubemap is a samplerCUBE datatype

			struct Input //we get information from our mesh through our input struct
			{
				float2 uv_myDiffuse; //we want our 2D uv's 
				float2 uv_myBump; //we want our 2D normals
				float3 worldRefl; INTERNAL_DATA //we want our world reflections which are a float 3 because
				//our world reflections are a 3d vector
				//we want this version of WorldRefl with the INTERNAL DATA afterwords to get reflection based
				//on a normal map, if we just used worldRefl it would not write to o.normal
			};
			
			void surf(Input IN, inout SurfaceOutput o)//Our shader method, we insert our Input struct and our Surface Output struct because we have a Lambert lighting model
			{
				o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb; //We set our albedo to a tex2D and use it's rgb values
				o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump )* _myBright);//WE use a normal map by setting o.normal and unpacking normals from our bump map and multiplying these by the  brightness to get afancier effect
				o.Normal *= float3(_mySlider, _mySlider, _mySlider);//We multiply our normal map by a float3 to adjust how intense how our normals are
				o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb; //We set our models emission to our
					//Cube map, taking into account our world reflection vector which needs our input struct
					//and our normals
			

			}


		ENDCG //The end of our cg code
	}
	Fallback "Diffuse" //our fallback shader is a simple diffuse shader

}