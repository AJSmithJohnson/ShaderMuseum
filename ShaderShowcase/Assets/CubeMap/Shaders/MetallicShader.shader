Shader "CubeMapShaders/MetallicShader"
{
	
	Properties
	{
		_bumpMap("A bump map", 2D) = "white"{}
		_cubeMap("A cube map",CUBE) = "white" {}
		_myRange("A range of numbers", Range(-3,  3)) = 0.5
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _bumpMap;
		samplerCUBE _cubeMap;
		float _myRange;
		struct Input
		{
			float2 uv_bumpMap;
			float3 worldRefl; INTERNAL_DATA
		};


		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Normal = UnpackNormal(tex2D(_bumpMap, IN.uv_bumpMap)) *_myRange;
			o.Albedo = texCUBE (_cubeMap, WorldReflectionVector(IN, o.Normal)).rgb;
		}
		ENDCG
	}
}