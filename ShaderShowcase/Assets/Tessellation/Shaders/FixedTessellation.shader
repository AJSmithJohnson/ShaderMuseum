Shader "TessellationShaders/FixedTessellation" //The folder name and name of our Shader
{
	Properties//The beginning of our properties block where we
	{//Will include anything we need to get from our inspector
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Our Main Texture", 2D) = "white" {}
		_DispTex("Our DisplacementTexture", 2D) = "gray" {}
		_DispIntensity("Our Displacement Intensity", Range(0, 1000)) = 0.3
		_Tess("Our Tesselation Amount", Range(-100, 500)) = 0.5
	}//The end of our properties block

		SubShader//The beginning of our subShader
		{
			CGPROGRAM//Start writing in HLSL
			#pragma surface surf Standard tessellate:tessFixed vertex:displacement //Our pragma where we declare we are writing a surface shader with


		//We redeclare the properties
		fixed4 _Color;
		sampler2D _MainTex;
		sampler2D _DispTex;
		float _DispIntensity;
		float _Tess;


		struct appdata
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
		};

		float4 tessFixed()//Our tessFixed method for tessellation
		{

		}//End of our tessFixed method
		void displacement(inout appdata v)//Our displacement method for vertex manipulation
		{

		}//End of our displacement method

		//a method named "surf" that is using the "Standard" PBR lighting model
		struct Input//Includes information we need to get from our model typically just UV's
		{
			float2 uv_MainTex;
		};//The end of our input struct


		void surf(Input IN, inout SurfaceOutputStandard o)//We declare our surf method
		{//This we pass in our Input struct and our lighting model with SurfaceOutputStandard because we our using Unity's built in 
		//Standard lighting model
			float4 tex = tex2D(_MainTex, IN.uv_MainTex).rgba;

			o.Albedo = tex *_Color;
		}//The end of our surface function declared in our pragma


		ENDCG//Stop writing in HLSL
	}//THE END OF OUR SUBSHADER
}