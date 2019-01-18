Shader "SurfaceShaderFolderName/SurfaceShaderName" //The folder name and name of our Shader
{
	Properties//The beginning of our properties block where we
	{//Will include anything we need to get from our inspector

	}//The end of our properties block

	SubShader//The beginning of our subShader
	{
		CGPROGRAM//Start writing in HLSL
		#pragma surface surf Standard//Our pragma where we declare we are writing a surface shader with
		//a method named "surf" that is using the "Standard" PBR lighting model
		struct Input//Includes information we need to get from our model typically just UV's
		{

		};//The end of our input struct


		void surf(Input IN, inout SurfaceOutputStandard o)//We declare our surf method
		{//This we pass in our Input struct and our lighting model with SurfaceOutputStandard because we our using Unity's built in 
		//Standard lighting model

		}//The end of our surface function declared in our pragma

		
		ENDCG//Stop writing in HLSL
	}//THE END OF OUR SUBSHADER
}