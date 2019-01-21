Shader "TessellationShaders/FixedTessellation" //The folder name and name of our Shader
{
	Properties//The beginning of our properties block where we
	{//Will include anything we need to get from our inspector
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Our Main Texture", 2D) = "white" {}
		_DispTex("Our DisplacementTexture", 2D) = "gray" {}
		_NormalTex("Our Normal texture", 2D) = "bump" {}
		_DispIntensity("Our Displacement Intensity", Range(0, 1000)) = 0.3
		_Tess("Our Tesselation Amount", Range(-100, 500)) = 0.5
	}//The end of our properties block

		SubShader//The beginning of our subShader
		{

			
			CGPROGRAM//Start writing in HLSL
			#pragma surface surf  Standard addshadow tessellate:tessFixed vertex:displacement	 //Our pragma where we declare we are writing a surface shader with
			#pragma target 4.6 
			
		//We redeclare the properties
		fixed4 _Color;
		sampler2D _MainTex;
		sampler2D _DispTex;
		float _DispIntensity;
		float _Tess;
		sampler2D _NormalTex;

		struct appdata
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
			float2 texcoord1: TEXCOORD1;
			float2 texcoord2: TEXCOORD2;
		};

		float4 tessFixed()//Our tessFixed method for tessellation
		{
			return _Tess;
		}//End of our tessFixed method
		void displacement(inout appdata v)//Our displacement method for vertex manipulation
		{
			
			float4 displacement = tex2Dlod(_DispTex, float4(v.texcoord.xy, 1, 1).r).rgba * _DispIntensity;
			//float4 displacement = tex2Dlod(_NormalTex, float4(v.texcoord.xy, 1, 1).r).rgba * _DispIntensity;
			v.vertex.xyz += v.normal * displacement;
		}//End of our displacement method

		//a method named "surf" that is using the "Standard" PBR lighting model
		struct Input//Includes information we need to get from our model typically just UV's
		{
			float2 uv_NormalTex;
			float2 uv_MainTex;
		};//The end of our input struct


		void surf(Input IN, inout SurfaceOutputStandard o)//We declare our surf method
		{//This we pass in our Input struct and our lighting model with SurfaceOutputStandard because we our using Unity's built in 
		//Standard lighting model
			float4 tex = tex2D(_MainTex, IN.uv_MainTex).rgba;
			o.Normal = tex2D(_NormalTex, IN.uv_MainTex).rgb;
			o.Albedo = tex *_Color;
		}//The end of our surface function declared in our pragma


		ENDCG//Stop writing in HLSL
	}//THE END OF OUR SUBSHADER
}