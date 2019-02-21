Shader "If_And_Or_Shaders/WorldPos"
{
	Properties
	{
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_BaseColor("Our base Color", Color) = (1,1,1,1)
		
	}
	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input
		{
			float3 viewDir;
			float3 worldPos;
		};

		float4 _RimColor;
		fixed4 _BaseColor;

		void surf(Input IN, inout SurfaceOutput o)
		{
			

			o.Emission = IN.worldPos.y > 1 ? _RimColor : _BaseColor;
		}


		ENDCG
	}

}