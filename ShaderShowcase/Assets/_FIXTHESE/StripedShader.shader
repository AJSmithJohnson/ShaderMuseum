Shader "If_And_Or_Shaders/Striped"
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
			

			o.Emission = frac(IN.worldPos.y*10 * 0.5) > 0.4 ? _RimColor : _BaseColor;
		}


		ENDCG
	}

}